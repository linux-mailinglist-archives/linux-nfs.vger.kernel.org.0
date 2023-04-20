Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C247C6E9D03
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjDTUVq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 16:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjDTUVk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 16:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B930FA
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682022007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOGuE4acm2Q22m97leeMXcm2SxrAGM8NsAkOjoKh0Gw=;
        b=fQ/tVvclCnXjXJVnEkVBV7PFUYWthfhN/iJTTOUDePf9DOKynSHFJUbW40kGfVc5bpzRLI
        etqivALVkkT8b3urvoPN5OrRQG/doPefluyITW3ztQto983+HWPb79PULSW+GksDRSIHFu
        CQupX6HwLouBsxHOG2c5SVyv0iwgs3I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-i1eI2FtZNAGh4CYMwr5tRQ-1; Thu, 20 Apr 2023 16:20:05 -0400
X-MC-Unique: i1eI2FtZNAGh4CYMwr5tRQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BE581C05AF2;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C939492B05;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id A97651A27FA; Thu, 20 Apr 2023 16:20:04 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: [RFC PATCH 5/5] SUNRPC: store GSS creds in keyrings
Date:   Thu, 20 Apr 2023 16:20:04 -0400
Message-Id: <20230420202004.239116-6-smayhew@redhat.com>
In-Reply-To: <20230420202004.239116-1-smayhew@redhat.com>
References: <20230420202004.239116-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch adds the option to store GSS credentials in keyrings as an
alternative to the RPC credential cache, to give users the ability to
destroy their GSS credentials on demand via 'keyctl unlink'.

Summary of the changes:

- Added key_type key_type_gss_cred and associated functions.  The
  request_key function makes use of the existing upcall mechanism to
  gssd.

- Added a keyring to the gss_auth struct to allow all of the assocated
  GSS credentials to be destroyed on RPC client shutdown (when the
  filesystem is unmounted).

- The key description contains the RPC client id, the user id, and the
  principal (for machine creds).

- The key payload contains the address of the gss_cred.

- The key is linked to the user's user keyring (KEY_SPEC_USER_KEYRING)
  as well as to the keyring on the gss_auth struct.

- gss_cred_init() now takes an optional pointer to an authkey, which is
  passed down to gss_create_upcall() and gss_setup_upcall(), where it is
  added to the gss_msg.  This is used for complete_request_key() after
  the upcall is done.

- put_rpccred() now returns a bool to indicate whether it called
  crdestroy(), and is used by gss_key_revoke() and gss_key_destroy() to
  determine whether to clear the key payload.

- gss_fill_context() now returns the GSS context's timeout via the tout
  parameter, which is used to set the timeout of the key.

- Added the module parameter 'use_keyring'.  When set to true, the GSS
  credentials are stored in the keyrings.  When false, the GSS
  credentials are stored in the RPC credential caches.

- Added a tracepoint to log the result of the key request, which prints
  either the key serial or an error return value.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 include/linux/sunrpc/auth.h    |   4 +-
 include/trace/events/rpcgss.h  |  46 ++++-
 net/sunrpc/auth.c              |   9 +-
 net/sunrpc/auth_gss/auth_gss.c | 338 +++++++++++++++++++++++++++++++--
 4 files changed, 376 insertions(+), 21 deletions(-)

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 3e6ce288a7fc..2a1fd8409396 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -124,7 +124,7 @@ struct rpc_authops {
 
 struct rpc_credops {
 	const char *		cr_name;	/* Name of the auth flavour */
-	int			(*cr_init)(struct rpc_auth *, struct rpc_cred *);
+	int			(*cr_init)(struct rpc_auth *, struct rpc_cred *, struct key *);
 	void			(*crdestroy)(struct rpc_cred *);
 
 	int			(*crmatch)(struct auth_cred *, struct rpc_cred *, int);
@@ -162,7 +162,7 @@ int			rpcauth_get_gssinfo(rpc_authflavor_t,
 struct rpc_cred *	rpcauth_lookup_credcache(struct rpc_auth *, struct auth_cred *, int, gfp_t);
 void			rpcauth_init_cred(struct rpc_cred *, const struct auth_cred *, struct rpc_auth *, const struct rpc_credops *);
 struct rpc_cred *	rpcauth_lookupcred(struct rpc_auth *, int);
-void			put_rpccred(struct rpc_cred *);
+bool			put_rpccred(struct rpc_cred *);
 int			rpcauth_marshcred(struct rpc_task *task,
 					  struct xdr_stream *xdr);
 int			rpcauth_checkverf(struct rpc_task *task,
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index ba2d96a1bc2f..3a9a0b343c4a 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -626,6 +626,40 @@ TRACE_EVENT(rpcgss_context,
 		__entry->timeout, __entry->len, __get_str(acceptor))
 );
 
+TRACE_EVENT(rpcgss_request_key_result,
+	TP_PROTO(
+		const struct auth_cred *acred,
+		const struct key *key
+	),
+
+	TP_ARGS(acred, key),
+
+	TP_STRUCT__entry(
+		__field(u32, uid)
+		__string(principal, acred->principal)
+		__field(const void *, credkey)
+		__field(int, serial)
+		__field(int, error)
+	),
+
+	TP_fast_assign(
+		__entry->uid = from_kuid(&init_user_ns, acred->cred->fsuid);
+		__assign_str(principal, acred->principal);
+		if (IS_ERR(key)) {
+			__entry->credkey = 0;
+			__entry->serial = 0;
+			__entry->error = PTR_ERR(key);
+		} else {
+			__entry->credkey = key;
+			__entry->serial = key->serial;
+			__entry->error = 0;
+		}
+	),
+
+	TP_printk(" for acred { uid %u princ %s }, key=%px serial=%d error=%d",
+		__entry->uid, __get_str(principal), __entry->credkey,
+		__entry->serial, __entry->error)
+);
 
 /**
  ** Miscellaneous events
@@ -645,24 +679,28 @@ TRACE_DEFINE_ENUM(RPC_AUTH_GSS_KRB5P);
 TRACE_EVENT(rpcgss_createauth,
 	TP_PROTO(
 		unsigned int flavor,
-		int error
+		int error,
+		const struct key *key
 	),
 
-	TP_ARGS(flavor, error),
+	TP_ARGS(flavor, error, key),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, flavor)
 		__field(int, error)
+		__field(const void *, keyring)
 
 	),
 
 	TP_fast_assign(
 		__entry->flavor = flavor;
 		__entry->error = error;
+		__entry->keyring = key;
 	),
 
-	TP_printk("flavor=%s error=%d",
-		show_pseudoflavor(__entry->flavor), __entry->error)
+	TP_printk("flavor=%s error=%d keyring=%px",
+		show_pseudoflavor(__entry->flavor), __entry->error,
+		__entry->keyring)
 );
 
 TRACE_EVENT(rpcgss_oid_to_mech,
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index fb75a883503f..972ca3c7385d 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -565,7 +565,7 @@ rpcauth_lookup_credcache(struct rpc_auth *auth, struct auth_cred * acred,
 	if (test_bit(RPCAUTH_CRED_NEW, &cred->cr_flags) &&
 	    cred->cr_ops->cr_init != NULL &&
 	    !(flags & RPCAUTH_LOOKUP_NEW)) {
-		int res = cred->cr_ops->cr_init(auth, cred);
+		int res = cred->cr_ops->cr_init(auth, cred, NULL);
 		if (res < 0) {
 			put_rpccred(cred);
 			cred = ERR_PTR(res);
@@ -683,11 +683,11 @@ rpcauth_bindcred(struct rpc_task *task, const struct cred *cred, int flags)
 	return 0;
 }
 
-void
+bool
 put_rpccred(struct rpc_cred *cred)
 {
 	if (cred == NULL)
-		return;
+		return false;
 	rcu_read_lock();
 	if (refcount_dec_and_test(&cred->cr_count))
 		goto destroy;
@@ -707,10 +707,11 @@ put_rpccred(struct rpc_cred *cred)
 	}
 out:
 	rcu_read_unlock();
-	return;
+	return false;
 destroy:
 	rcu_read_unlock();
 	cred->cr_ops->crdestroy(cred);
+	return true;
 }
 EXPORT_SYMBOL_GPL(put_rpccred);
 
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 1af71fbb0d80..f97cbf9655ca 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -28,12 +28,26 @@
 #include <linux/sunrpc/gss_api.h>
 #include <linux/uaccess.h>
 #include <linux/hashtable.h>
+#include <linux/key.h>
+#include <linux/keyctl.h>
+#include <linux/key-type.h>
+#include <keys/user-type.h>
+#include <keys/request_key_auth-type.h>
 
 #include "auth_gss_internal.h"
 #include "../netns.h"
 
 #include <trace/events/rpcgss.h>
 
+#define UINT_MAX_LEN 11
+static const char CLID_PREFIX[] = "clid:";
+static const char ID_PREFIX[] = "id:";
+static const char PRINC_PREFIX[] = "princ:";
+static const char PRINC_NONE[] = "princ:(none)";
+static struct key_type key_type_gss_cred;
+
+void gss_key_destroy(struct key *key);
+
 static const struct rpc_authops authgss_ops;
 
 static const struct rpc_credops gss_credops;
@@ -45,6 +59,8 @@ static unsigned int gss_expired_cred_retry_delay = GSS_RETRY_EXPIRED;
 #define GSS_KEY_EXPIRE_TIMEO 240
 static unsigned int gss_key_expire_timeo = GSS_KEY_EXPIRE_TIMEO;
 
+static bool use_keyring;
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
@@ -98,6 +114,14 @@ struct gss_auth {
 	 */
 	struct gss_pipe *gss_pipe[2];
 	const char *target_name;
+	struct cred *keyring_cred;
+};
+
+struct gss_auxdata {
+	struct rpc_auth *auth;
+	struct auth_cred *acred;
+	int flags;
+	gfp_t gfp;
 };
 
 /* pipe_version >= 0 if and only if someone has a pipe open. */
@@ -174,7 +198,8 @@ gss_alloc_context(void)
 
 #define GSSD_MIN_TIMEOUT (60 * 60)
 static const void *
-gss_fill_context(const void *p, const void *end, struct gss_cl_ctx *ctx, struct gss_api_mech *gm)
+gss_fill_context(const void *p, const void *end, struct gss_cl_ctx *ctx,
+		 struct gss_api_mech *gm, unsigned int *tout)
 {
 	const void *q;
 	unsigned int seclen;
@@ -192,6 +217,7 @@ gss_fill_context(const void *p, const void *end, struct gss_cl_ctx *ctx, struct
 		goto err;
 	if (timeout == 0)
 		timeout = GSSD_MIN_TIMEOUT;
+	*tout = timeout;
 	ctx->gc_expiry = now + ((unsigned long)timeout * HZ);
 	/* Sequence number window. Determines the maximum number of
 	 * simultaneous requests
@@ -267,6 +293,8 @@ struct gss_upcall_msg {
 	struct rpc_wait_queue rpc_waitqueue;
 	wait_queue_head_t waitqueue;
 	struct gss_cl_ctx *ctx;
+	struct key *authkey;
+	unsigned int timeout;
 	char databuf[UPCALL_BUF_LEN];
 };
 
@@ -559,7 +587,8 @@ gss_alloc_msg(struct gss_auth *gss_auth,
 }
 
 static struct gss_upcall_msg *
-gss_setup_upcall(struct gss_auth *gss_auth, struct rpc_cred *cred)
+gss_setup_upcall(struct gss_auth *gss_auth, struct rpc_cred *cred,
+		 struct key *authkey)
 {
 	struct gss_cred *gss_cred = container_of(cred,
 			struct gss_cred, gc_base);
@@ -572,6 +601,7 @@ gss_setup_upcall(struct gss_auth *gss_auth, struct rpc_cred *cred)
 	gss_msg = gss_add_msg(gss_new);
 	if (gss_msg == gss_new) {
 		int res;
+		gss_msg->authkey = authkey;
 		refcount_inc(&gss_msg->count);
 		res = rpc_queue_upcall(gss_new->pipe, &gss_new->msg);
 		if (res) {
@@ -602,7 +632,7 @@ gss_refresh_upcall(struct rpc_task *task)
 	struct rpc_pipe *pipe;
 	int err = 0;
 
-	gss_msg = gss_setup_upcall(gss_auth, cred);
+	gss_msg = gss_setup_upcall(gss_auth, cred, NULL);
 	if (PTR_ERR(gss_msg) == -EAGAIN) {
 		/* XXX: warning on the first, under the assumption we
 		 * shouldn't normally hit this case on a refresh. */
@@ -638,16 +668,23 @@ gss_refresh_upcall(struct rpc_task *task)
 }
 
 static inline int
-gss_create_upcall(struct gss_auth *gss_auth, struct gss_cred *gss_cred)
+gss_create_upcall(struct gss_auth *gss_auth, struct gss_cred *gss_cred,
+		  struct key *authkey)
 {
 	struct net *net = gss_auth->net;
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 	struct rpc_pipe *pipe;
 	struct rpc_cred *cred = &gss_cred->gc_base;
 	struct gss_upcall_msg *gss_msg;
+	struct request_key_auth *rka;
+	struct key *key;
 	DEFINE_WAIT(wait);
 	int err;
 
+	if (use_keyring) {
+		rka = get_request_key_auth(authkey);
+		key = rka->target_key;
+	}
 retry:
 	err = 0;
 	/* if gssd is down, just skip upcalling altogether */
@@ -656,7 +693,7 @@ gss_create_upcall(struct gss_auth *gss_auth, struct gss_cred *gss_cred)
 		err = -EACCES;
 		goto out;
 	}
-	gss_msg = gss_setup_upcall(gss_auth, cred);
+	gss_msg = gss_setup_upcall(gss_auth, cred, authkey);
 	if (PTR_ERR(gss_msg) == -EAGAIN) {
 		err = wait_event_interruptible_timeout(pipe_version_waitqueue,
 				sn->pipe_version >= 0, 15 * HZ);
@@ -689,6 +726,17 @@ gss_create_upcall(struct gss_auth *gss_auth, struct gss_cred *gss_cred)
 	if (gss_msg->ctx) {
 		trace_rpcgss_ctx_init(gss_cred);
 		gss_cred_set_ctx(cred, gss_msg->ctx);
+		if (use_keyring) {
+			err = key_instantiate_and_link(key, gss_cred,
+						       sizeof(gss_cred),
+						       NULL, authkey);
+			if (!err) {
+				key_set_timeout(key, gss_msg->timeout);
+				err = key_link(gss_auth->keyring_cred->thread_keyring,
+					       key);
+			}
+			complete_request_key(authkey, err);
+		}
 	} else {
 		err = gss_msg->msg.errno;
 	}
@@ -771,7 +819,8 @@ gss_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	list_del_init(&gss_msg->list);
 	spin_unlock(&pipe->lock);
 
-	p = gss_fill_context(p, end, ctx, gss_msg->auth->mech);
+	p = gss_fill_context(p, end, ctx, gss_msg->auth->mech,
+			     &gss_msg->timeout);
 	if (IS_ERR(p)) {
 		err = PTR_ERR(p);
 		switch (err) {
@@ -1032,6 +1081,8 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 	struct gss_pipe *gss_pipe;
 	struct rpc_auth * auth;
 	int err = -ENOMEM; /* XXX? */
+	struct cred *cred;
+	struct key *keyring;
 
 	if (!try_module_get(THIS_MODULE))
 		return ERR_PTR(err);
@@ -1094,7 +1145,34 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 	}
 	gss_auth->gss_pipe[0] = gss_pipe;
 
+	if (use_keyring) {
+		cred = prepare_kernel_cred(&init_task);
+		if (!cred) {
+			err = -ENOMEM;
+			goto err_destroy_pipe_0;
+		}
+		keyring = keyring_alloc("gss_keyring",
+					GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
+					(KEY_POS_ALL & ~KEY_POS_SETATTR) |
+					KEY_USR_VIEW | KEY_USR_READ,
+					KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
+		if (IS_ERR(keyring)) {
+			err = PTR_ERR(keyring);
+			goto err_destroy_cred;
+		}
+		set_bit(KEY_FLAG_ROOT_CAN_CLEAR, &keyring->flags);
+		cred->thread_keyring = keyring;
+		cred->jit_keyring = KEY_REQKEY_DEFL_THREAD_KEYRING;
+		gss_auth->keyring_cred = cred;
+	}
+
+	trace_rpcgss_createauth(flavor, err, gss_auth->keyring_cred ?
+				gss_auth->keyring_cred->thread_keyring : NULL);
 	return gss_auth;
+err_destroy_cred:
+	put_cred(cred);
+err_destroy_pipe_0:
+	gss_pipe_free(gss_auth->gss_pipe[0]);
 err_destroy_pipe_1:
 	gss_pipe_free(gss_auth->gss_pipe[1]);
 err_destroy_credcache:
@@ -1108,7 +1186,8 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 	kfree(gss_auth);
 out_dec:
 	module_put(THIS_MODULE);
-	trace_rpcgss_createauth(flavor, err);
+	trace_rpcgss_createauth(flavor, err, gss_auth->keyring_cred ?
+				gss_auth->keyring_cred->thread_keyring : NULL);
 	return ERR_PTR(err);
 }
 
@@ -1139,6 +1218,19 @@ gss_put_auth(struct gss_auth *gss_auth)
 	kref_put(&gss_auth->kref, gss_free_callback);
 }
 
+static bool gss_key_gc_iterator(void *object, void *__unused)
+{
+	struct key *key = keyring_ptr_to_key(object);
+	struct gss_cred *cred = key->payload.data[0];
+
+	if (cred && put_rpccred(&cred->gc_base)) {
+		key->payload.data[0] = NULL;
+		return false;
+	}
+	key_get(key);
+	return true;
+}
+
 static void
 gss_destroy(struct rpc_auth *auth)
 {
@@ -1157,6 +1249,13 @@ gss_destroy(struct rpc_auth *auth)
 	gss_auth->gss_pipe[1] = NULL;
 	rpcauth_destroy_credcache(auth);
 
+	if (use_keyring) {
+		keyring_gc_custom(gss_auth->keyring_cred->thread_keyring,
+				  &gss_key_gc_iterator, NULL);
+		key_revoke(gss_auth->keyring_cred->thread_keyring);
+		put_cred(gss_auth->keyring_cred);
+	}
+
 	gss_put_auth(gss_auth);
 }
 
@@ -1369,14 +1468,109 @@ gss_hash_cred(struct auth_cred *acred, unsigned int hashbits)
 	return hash_64(from_kuid(&init_user_ns, acred->cred->fsuid), hashbits);
 }
 
+static struct key *gss_request_key(struct rpc_auth *auth,
+				   struct auth_cred *acred,
+				   int flags, gfp_t gfp)
+{
+	struct gss_auth *gss_auth = container_of(auth, struct gss_auth, rpc_auth);
+	struct key *key;
+	struct gss_auxdata *aux;
+	char clid_str[UINT_MAX_LEN];
+	char id_str[UINT_MAX_LEN];
+	char *desc;
+	int clid_len, id_len, desclen;
+	struct key *dest_keyring;
+	key_ref_t keyref;
+
+	keyref = lookup_user_key(KEY_SPEC_USER_KEYRING,
+				 KEY_LOOKUP_CREATE, KEY_NEED_SEARCH);
+	if (IS_ERR(keyref))
+		return ERR_CAST(keyref);
+	dest_keyring = key_ref_to_ptr(keyref);
+
+	clid_len = snprintf(clid_str, sizeof(clid_str), "%u",
+			    gss_auth->client->cl_clid);
+	id_len = snprintf(id_str, sizeof(id_str), "%u",
+			  from_kuid(&init_user_ns, acred->cred->fsuid));
+
+	desclen = sizeof(CLID_PREFIX) + clid_len + 1 +
+			sizeof(ID_PREFIX) + id_len;
+
+	if (acred->principal)
+		desclen += (1 + sizeof(PRINC_PREFIX) + strlen(acred->principal));
+	else
+		desclen += (1 + sizeof(PRINC_NONE));
+
+	desc = kmalloc(desclen, GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	if (acred->principal)
+		sprintf(desc, "%s%s %s%s %s%s", CLID_PREFIX, clid_str,
+			ID_PREFIX, id_str, PRINC_PREFIX, acred->principal);
+	else
+		sprintf(desc, "%s%s %s%s %s", CLID_PREFIX, clid_str,
+			ID_PREFIX, id_str, PRINC_NONE);
+
+	aux = kzalloc(sizeof(*aux), gfp);
+	if (!aux)
+		return ERR_PTR(-ENOMEM);
+
+	aux->auth = auth;
+	aux->acred = acred;
+	aux->flags = flags;
+	aux->gfp = gfp;
+
+	key = request_key_with_auxdata(&key_type_gss_cred, desc,
+				       NULL, "", 0, aux, dest_keyring);
+	kfree(aux);
+	kfree(desc);
+	return key;
+}
+
+static struct rpc_cred *
+gss_lookup_keyring(struct rpc_auth *auth, struct auth_cred *acred,
+		   int flags, gfp_t gfp)
+{
+	struct key *key;
+	struct gss_cred *gss_cred;
+	struct rpc_cred *cred = NULL;
+	const struct cred *saved_cred;
+
+	saved_cred = override_creds(acred->cred);
+	key = gss_request_key(auth, acred, flags, rpc_task_gfp_mask());
+	trace_rpcgss_request_key_result(acred, key);
+	if (IS_ERR(key)) {
+		cred = ERR_CAST(key);
+		goto out;
+	}
+	down_read(&key->sem);
+	gss_cred = key->payload.data[0];
+	if (!gss_cred) {
+		cred = ERR_PTR(-ENOKEY);
+		goto out_up;
+	}
+	cred = get_rpccred(&gss_cred->gc_base);
+out_up:
+	up_read(&key->sem);
+	key_put(key);
+out:
+	revert_creds(saved_cred);
+	return cred;
+}
+
 /*
  * Lookup RPCSEC_GSS cred for the current process
  */
 static struct rpc_cred *gss_lookup_cred(struct rpc_auth *auth,
 					struct auth_cred *acred, int flags)
 {
-	return rpcauth_lookup_credcache(auth, acred, flags,
-					rpc_task_gfp_mask());
+	if (use_keyring)
+		return gss_lookup_keyring(auth, acred, flags,
+					  rpc_task_gfp_mask());
+	else
+		return rpcauth_lookup_credcache(auth, acred, flags,
+						rpc_task_gfp_mask());
 }
 
 static struct rpc_cred *
@@ -1405,18 +1599,128 @@ gss_create_cred(struct rpc_auth *auth, struct auth_cred *acred, int flags, gfp_t
 }
 
 static int
-gss_cred_init(struct rpc_auth *auth, struct rpc_cred *cred)
+gss_cred_init(struct rpc_auth *auth, struct rpc_cred *cred, struct key *authkey)
 {
 	struct gss_auth *gss_auth = container_of(auth, struct gss_auth, rpc_auth);
 	struct gss_cred *gss_cred = container_of(cred,struct gss_cred, gc_base);
 	int err;
 
 	do {
-		err = gss_create_upcall(gss_auth, gss_cred);
+		err = gss_create_upcall(gss_auth, gss_cred, authkey);
 	} while (err == -EAGAIN);
 	return err;
 }
 
+static bool gss_cmp(const struct key *key,
+		    const struct key_match_data *match_data)
+{
+	struct gss_cred *gss_cred = rcu_dereference(key->payload.rcu_data0);
+	struct rpc_cred *rc;
+	struct gss_cl_ctx *ctx;
+	bool ret;
+
+	if (!gss_cred)
+		return false;
+
+	rc = &gss_cred->gc_base;
+
+	if (test_bit(RPCAUTH_CRED_NEW, &rc->cr_flags))
+		goto out;
+	/* Don't match with creds that have expired. */
+	ctx = rcu_dereference(gss_cred->gc_ctx);
+	if (!ctx || time_after(jiffies, ctx->gc_expiry)) {
+		rcu_read_unlock();
+		return false;
+	}
+	if (!test_bit(RPCAUTH_CRED_UPTODATE, &rc->cr_flags)) {
+		return false;
+	}
+out:
+	ret = strcmp(key->description, match_data->raw_data) == 0;
+	return ret;
+}
+
+static int gss_match_preparse(struct key_match_data *match_data)
+{
+	match_data->cmp = gss_cmp;
+	match_data->lookup_type = KEYRING_SEARCH_LOOKUP_ITERATE;
+	return 0;
+}
+
+static int gss_request_key_upcall(struct key *authkey, void *aux)
+{
+	struct gss_auxdata *data = aux;
+	struct rpc_auth *auth = data->auth;
+	struct auth_cred *acred = data->acred;
+	int flags = data->flags;
+	gfp_t gfp = data->gfp;
+	struct rpc_cred *cred;
+	int ret;
+
+	cred = gss_create_cred(auth, acred, flags, gfp);
+	if (IS_ERR(cred)) {
+		ret = PTR_ERR(cred);
+		complete_request_key(authkey, ret);
+		return ret;
+	}
+
+	ret = gss_cred_init(auth, cred, authkey);
+	if (ret < 0) {
+		complete_request_key(authkey, ret);
+	}
+
+	return ret;
+}
+
+void gss_key_revoke(struct key *key)
+{
+	struct gss_cred *cred = key->payload.data[0];
+
+	if (cred && put_rpccred(&cred->gc_base))
+		key->payload.data[0] = NULL;
+}
+
+void gss_key_destroy(struct key *key)
+{
+	struct gss_cred *cred = key->payload.data[0];
+
+	if (cred && put_rpccred(&cred->gc_base))
+		key->payload.data[0] = NULL;
+}
+
+void gss_describe(const struct key *key, struct seq_file *m)
+{
+	struct gss_cred *gss_cred = key->payload.data[0];
+
+	if (!gss_cred)
+		return;
+
+	seq_puts(m, key->description);
+	if (key_is_positive(key)) {
+		seq_printf(m, " gc: %px", gss_cred);
+	}
+}
+
+int gss_key_instantiate(struct key *key, struct key_preparsed_payload *prep)
+{
+	if (prep->datalen != key->type->def_datalen)
+		return -EINVAL;
+
+	rcu_assign_keypointer(key, (struct gss_cred *)prep->data);
+	return 0;
+}
+
+static struct key_type key_type_gss_cred = {
+	.name = "gss_cred",
+	.def_datalen	= sizeof(struct gss_cred *),
+	.instantiate	= gss_key_instantiate,
+	.match_preparse = gss_match_preparse,
+	.revoke		= gss_key_revoke,
+	.destroy	= gss_key_destroy,
+	.describe	= gss_describe,
+	.request_key	= gss_request_key_upcall,
+};
+
 static char *
 gss_stringify_acceptor(struct rpc_cred *cred)
 {
@@ -2261,6 +2565,11 @@ static int __init init_rpcsec_gss(void)
 	err = register_pernet_subsys(&rpcsec_gss_net_ops);
 	if (err)
 		goto out_svc_exit;
+	if (use_keyring) {
+		err = register_key_type(&key_type_gss_cred);
+		if (err)
+			goto out_svc_exit;
+	}
 	rpc_init_wait_queue(&pipe_version_rpc_waitqueue, "gss pipe version");
 	return 0;
 out_svc_exit:
@@ -2273,6 +2582,8 @@ static int __init init_rpcsec_gss(void)
 
 static void __exit exit_rpcsec_gss(void)
 {
+	if (use_keyring)
+		unregister_key_type(&key_type_gss_cred);
 	unregister_pernet_subsys(&rpcsec_gss_net_ops);
 	gss_svc_shutdown();
 	rpcauth_unregister(&authgss_ops);
@@ -2294,5 +2605,10 @@ MODULE_PARM_DESC(key_expire_timeo, "Time (in seconds) at the end of a "
 		"credential keys lifetime where the NFS layer cleans up "
 		"prior to key expiration");
 
+module_param(use_keyring, bool, 0444);
+MODULE_PARM_DESC(use_keyring,
+		 "Store credentials in keyrings instead of credential cache. "
+		 "Default: false");
+
 module_init(init_rpcsec_gss)
 module_exit(exit_rpcsec_gss)
-- 
2.39.2

