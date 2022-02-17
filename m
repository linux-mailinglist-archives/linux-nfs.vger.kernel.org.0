Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CDF4BA055
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 13:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbiBQMtP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 07:49:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiBQMtP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 07:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96D192A82D7
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 04:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645102138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHp8PLxbPmWxdT+MDJch7bKx9T9Pf5js4zOeyb8vko8=;
        b=Ldi72NTlkqS4Qdpe0SZ15b6w5xhiIgXp2PTuY3Aftvu7xLPvGLQ6IdbefMWM3Ndz8C+/Gw
        zwXjqp2J9GEFGt2oAYaZq3fLnY9MqZR3mF4w9KvL20WHSf2JZnXn/nzrHUaY7YD1I2n1JT
        QvSlLQDWccnoksR68pRDpVjb9Sfa5LU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-VH298htINee9h4rBQ3vdxg-1; Thu, 17 Feb 2022 07:48:57 -0500
X-MC-Unique: VH298htINee9h4rBQ3vdxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85C3D1006AA0;
        Thu, 17 Feb 2022 12:48:55 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00DA66FB70;
        Thu, 17 Feb 2022 12:48:54 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Date:   Thu, 17 Feb 2022 07:48:53 -0500
Message-ID: <3EA14A5C-9FF9-4DDC-B530-768A86E2A4E8@redhat.com>
In-Reply-To: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
References: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond and Anna, this patch makes obvious one problem with the udev 
approach.
We cannot depend fully on stable uniquifiers.  The conversation on the
userspace side has come full circle to asserting we use a mount option.

Do you still want us to keep this approach, or will you accept a mount
option as:
  - first mount in a namespace sets the identifier
  - subsequent mounts with conflicting identifiers return an error

If we keep this udev approach, this patch isn't necessary but does 
greatly
reduce the chances of having clients with unstable identifiers.

No one can be blamed for ignoring this, but it would be a relief to get 
this
problem solved so it can stop burning our time.

Please advise,
Ben

On 16 Feb 2022, at 12:42, Benjamin Coddington wrote:

> In order to set a unique but persistent value for the nfs client's ID, 
> the
> client exposes a per-network-namespace sysfs file that can be used to
> configure a "uniquifier" for this value.
>
> However any userspace mechanism used to configure this value must do 
> so in
> the potentially small window between either (1) the nfs module getting
> loaded or (2) the creation of a new network namespace, and the client
> sending SETCLIENTID or EXCHANGE_ID.
>
> In (1) the time between these events can be very small if the kernel 
> loads
> the nfs module as triggered by the first mount request.  That leaves 
> little
> time for another process such as a userspace helper to lookup or 
> generate a
> uniquifier and write it to the kernel before the kernel attempts to 
> create
> and use the identifier.
>
> In (2) the network namespace may be created but network configuration 
> and
> processes within that namespace that may trigger on the creation of 
> the
> sysfs file are not ready, or the setup of filesystems and tools for 
> that
> namespace may happen in parallel.
>
> Fix this by creating a new nfs module parameter 
> "nfs4_unique_id_timeout"
> that will allow userspace a tunable window of time to uniquify the 
> client.
> When set, the client waits for a uniquifier to be set before sending
> SETCLIENTID or EXCHANGE_ID.  The parameter defaults to 500ms. Setting 
> the
> parameter to zero reverts any waiting for a uniquifier.
>
> A tunable delay can accommodate situations where the size of the race
> window needs to be modified due to hardware differences or various
> approaches to container initialization with respect to the use of NFS
> within those containers.
>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/nfs4_fs.h  | 1 +
>  fs/nfs/nfs4proc.c | 4 ++++
>  fs/nfs/super.c    | 4 ++++
>  fs/nfs/sysfs.c    | 3 +++
>  fs/nfs/sysfs.h    | 2 ++
>  5 files changed, 14 insertions(+)
>
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index 3e344bec3647..052805c3cfc0 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -544,6 +544,7 @@ extern bool recover_lost_locks;
>
>  #define NFS4_CLIENT_ID_UNIQ_LEN		(64)
>  extern char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN];
> +extern unsigned int nfs4_client_id_uniquifier_timeout;
>
>  extern int nfs4_try_get_tree(struct fs_context *);
>  extern int nfs4_get_referral_tree(struct fs_context *);
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 3106bd28b113..2ddffd799c7f 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -6135,6 +6135,10 @@ nfs4_get_uniquifier(struct nfs_client *clp, 
> char *buf, size_t buflen)
>  	buf[0] = '\0';
>
>  	if (nn_clp) {
> +		if (!nn_clp->user_uniquified && nfs4_client_id_uniquifier_timeout)
> +			wait_for_completion_interruptible_timeout(&nn_clp->uniquified,
> +				msecs_to_jiffies(nfs4_client_id_uniquifier_timeout));
> +
>  		rcu_read_lock();
>  		id = rcu_dereference(nn_clp->identifier);
>  		if (id)
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 4034102010f0..cad5acd1f79d 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1329,6 +1329,7 @@ unsigned short max_session_slots = 
> NFS4_DEF_SLOT_TABLE_SIZE;
>  unsigned short max_session_cb_slots = NFS4_DEF_CB_SLOT_TABLE_SIZE;
>  unsigned short send_implementation_id = 1;
>  char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN] = "";
> +unsigned int nfs4_client_id_uniquifier_timeout = 500;
>  bool recover_lost_locks = false;
>
>  EXPORT_SYMBOL_GPL(nfs_callback_nr_threads);
> @@ -1339,6 +1340,7 @@ EXPORT_SYMBOL_GPL(max_session_slots);
>  EXPORT_SYMBOL_GPL(max_session_cb_slots);
>  EXPORT_SYMBOL_GPL(send_implementation_id);
>  EXPORT_SYMBOL_GPL(nfs4_client_id_uniquifier);
> +EXPORT_SYMBOL_GPL(nfs4_client_id_uniquifier_timeout);
>  EXPORT_SYMBOL_GPL(recover_lost_locks);
>
>  #define NFS_CALLBACK_MAXPORTNR (65535U)
> @@ -1370,6 +1372,7 @@ module_param(nfs_idmap_cache_timeout, int, 
> 0644);
>  module_param(nfs4_disable_idmapping, bool, 0644);
>  module_param_string(nfs4_unique_id, nfs4_client_id_uniquifier,
>  			NFS4_CLIENT_ID_UNIQ_LEN, 0600);
> +module_param_named(nfs4_unique_id_timeout, 
> nfs4_client_id_uniquifier_timeout, int, 0644);
>  MODULE_PARM_DESC(nfs4_disable_idmapping,
>  		"Turn off NFSv4 idmapping when using 'sec=sys'");
>  module_param(max_session_slots, ushort, 0644);
> @@ -1382,6 +1385,7 @@ module_param(send_implementation_id, ushort, 
> 0644);
>  MODULE_PARM_DESC(send_implementation_id,
>  		"Send implementation ID with NFSv4.1 exchange_id");
>  MODULE_PARM_DESC(nfs4_unique_id, "nfs_client_id4 uniquifier string");
> +MODULE_PARM_DESC(nfs4_unique_id_timeout, "msecs to wait for 
> nfs_client_id4 uniquifier string");
>
>  module_param(recover_lost_locks, bool, 0644);
>  MODULE_PARM_DESC(recover_lost_locks,
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index be05522a2c8b..a54d342bc381 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -117,6 +117,8 @@ static ssize_t nfs_netns_identifier_store(struct 
> kobject *kobj,
>  		synchronize_rcu();
>  		kfree(old);
>  	}
> +	c->user_uniquified = true;
> +	complete(&c->uniquified);
>  	return count;
>  }
>
> @@ -171,6 +173,7 @@ static struct nfs_netns_client 
> *nfs_netns_client_alloc(struct kobject *parent,
>  	if (p) {
>  		if (net != &init_net)
>  			assign_unique_clientid(p);
> +		init_completion(&p->uniquified);
>  		p->net = net;
>  		p->kobject.kset = nfs_client_kset;
>  		if (kobject_init_and_add(&p->kobject, &nfs_netns_client_type,
> diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
> index 5501ef573c32..f733439a1084 100644
> --- a/fs/nfs/sysfs.h
> +++ b/fs/nfs/sysfs.h
> @@ -12,6 +12,8 @@ struct nfs_netns_client {
>  	struct kobject kobject;
>  	struct net *net;
>  	const char __rcu *identifier;
> +	bool user_uniquified;
> +	struct completion uniquified;
>  };
>
>  extern struct kobject *nfs_client_kobj;
> -- 
> 2.31.1

