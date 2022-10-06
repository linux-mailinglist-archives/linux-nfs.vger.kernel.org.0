Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1225F6395
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiJFJZM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiJFJZI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 05:25:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC0D2F38A
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 02:25:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3707021883;
        Thu,  6 Oct 2022 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665048306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKcFNoAZOQZK1iIA87xLj0xEbaGoWxk6/jvllZeW/gk=;
        b=cSzbaWTghnq8YVzo/n9ld5X28yNvXaXl0KgHUvXKlofeoUCsTtW3qht9pysWJUoSTttpPD
        644ZZ8RgbRDyU2yukegfz5l4vQ2b12Qi9VobKbNv9PMYEFa6zApMre5S0VONEWXNTV6pCI
        Y0KzPpi9RoPDAAYEEOf3qesk0ACSbs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665048306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKcFNoAZOQZK1iIA87xLj0xEbaGoWxk6/jvllZeW/gk=;
        b=hmWOmmbJJlAszCtW+tK6OUWCYa6mv/vmCMuYm1svsapq/i/E/mAQwVIcYPrIv96U2P7qdI
        gfbc1OWyjoFGwXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 225F91376E;
        Thu,  6 Oct 2022 09:25:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yQjKB/KePmMQUgAAMHmgww
        (envelope-from <ohollmann@suse.cz>); Thu, 06 Oct 2022 09:25:06 +0000
Message-ID: <5b71cb5cbdc6531172b466323fd8840a3a4644dc.camel@suse.cz>
Subject: Re: [PATCH] binddynport.c honor ip_local_reserved_ports
From:   Otto Hollmann <ohollmann@suse.cz>
To:     Steve Dickson <steved@redhat.com>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org, Thomas Blume <thomas.blume@suse.com>
Date:   Thu, 06 Oct 2022 11:25:05 +0200
In-Reply-To: <4ed1d7983c5ff021c80fa2b70a056b1bb954f865.camel@suse.cz>
References: <1654766776.2720.14.camel@suse.cz>
         <d59de44c-4716-cf5d-906b-5a3d8685f53b@redhat.com>
         <4ed1d7983c5ff021c80fa2b70a056b1bb954f865.camel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For the record, I'm sending an updated patch with static functions.


Signed-off-by: Otto Hollmann <otto.hollmann@suse.com>
---
 src/binddynport.c | 107 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 8 deletions(-)

diff --git a/src/binddynport.c b/src/binddynport.c
index 062629a..90e2748 100644
--- a/src/binddynport.c
+++ b/src/binddynport.c
@@ -37,6 +37,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
+#include <syslog.h>
=20
 #include <rpc/rpc.h>
=20
@@ -56,6 +57,84 @@ enum {
 	NPORTS		=3D ENDPORT - LOWPORT + 1,
 };
=20
+/*
+ * This function decodes information about given port from provided array =
and
+ * return if port is reserved or not.
+ *
+ * @reserved_ports an array of size at least "NPORTS / (8*sizeof(char)) + =
1".
+ * @port port number within range LOWPORT and ENDPORT
+ *
+ * Returns 0 if port is not reserved, non-negative if port is reserved.
+ */
+static int is_reserved(char *reserved_ports, int port) {
+	port -=3D LOWPORT;
+	if (port < 0 || port >=3D NPORTS)
+		return 0;
+	return reserved_ports[port/(8*sizeof(char))] & 1<<(port%(8*sizeof(char)))=
;
+}
+
+/*
+ * This function encodes information about given *reserved* port into prov=
ided
+ * array. Don't call this function for ports which are not reserved.
+ *
+ * @reserved_ports an array of size at least "NPORTS / (8*sizeof(char)) + =
1".
+ * @port port number within range LOWPORT and ENDPORT
+ *
+ */
+static void set_reserved(char *reserved_ports, int port) {
+	port -=3D LOWPORT;
+	if (port < 0 || port >=3D NPORTS)
+		return;
+	reserved_ports[port/(8*sizeof(char))] |=3D 1<<(port%(8*sizeof(char)));
+}
+
+/*
+ * Parse local reserved ports obtained from
+ * /proc/sys/net/ipv4/ip_local_reserved_ports into bit array.
+ *
+ * @reserved_ports a zeroed array of size at least
+ * "NPORTS / (8*sizeof(char)) + 1". Will be used for bit-wise encoding of
+ * reserved ports.
+ *
+ * On each call, reserved ports are read from /proc and bit-wise stored in=
to
+ * provided array
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+
+static int parse_reserved_ports(char *reserved_ports) {
+	int from, to;
+	char delimiter =3D ',';
+	int res;
+	FILE * file_ptr =3D fopen("/proc/sys/net/ipv4/ip_local_reserved_ports","r=
");
+	if (file_ptr =3D=3D NULL) {
+		(void) syslog(LOG_ERR,
+			"Unable to open open /proc/sys/net/ipv4/ip_local_reserved_ports.");
+		return -1;
+	}
+	do {
+		if ((res =3D fscanf(file_ptr, "%d", &to)) !=3D 1) {
+			if (res =3D=3D EOF) break;
+			goto err;
+		}
+		if (delimiter !=3D '-') {
+			from =3D to;
+		}
+		for (int i =3D from; i <=3D to; ++i) {
+			set_reserved(reserved_ports, i);
+		}
+	} while ((res =3D fscanf(file_ptr, "%c", &delimiter)) =3D=3D 1);
+	if (res !=3D EOF)
+		goto err;
+	fclose(file_ptr);
+	return 0;
+err:
+	(void) syslog(LOG_ERR,
+		"An error occurred while parsing ip_local_reserved_ports.");
+	fclose(file_ptr);
+	return -1;
+}
+
 /*
  * Bind a socket to a dynamically-assigned IP port.
  *
@@ -81,7 +160,8 @@ int __binddynport(int fd)
 	in_port_t port, *portp;
 	struct sockaddr *sap;
 	socklen_t salen;
-	int i, res;
+	int i, res, array_size;
+	char *reserved_ports;
=20
 	if (__rpc_sockisbound(fd))
 		return 0;
@@ -119,21 +199,32 @@ int __binddynport(int fd)
 		gettimeofday(&tv, NULL);
 		seed =3D tv.tv_usec * getpid();
 	}
+	array_size =3D NPORTS / (8*sizeof(char)) + 1;
+	reserved_ports =3D malloc(array_size);
+	if (!reserved_ports) {
+		goto out;
+	}
+	memset(reserved_ports, 0, array_size);
+	parse_reserved_ports(reserved_ports);
+
 	port =3D (rand_r(&seed) % NPORTS) + LOWPORT;
 	for (i =3D 0; i < NPORTS; ++i) {
-		*portp =3D htons(port++);
-		res =3D bind(fd, sap, salen);
-		if (res >=3D 0) {
-			res =3D 0;
-			break;
+		*portp =3D htons(port);
+		if (!is_reserved(reserved_ports, port++)) {
+			res =3D bind(fd, sap, salen);
+			if (res >=3D 0) {
+				res =3D 0;
+				break;
+			}
+			if (errno !=3D EADDRINUSE)
+				break;
 		}
-		if (errno !=3D EADDRINUSE)
-			break;
 		if (port > ENDPORT)
 			port =3D LOWPORT;
 	}
=20
 out:
+	free(reserved_ports);
 	mutex_unlock(&port_lock);
 	return res;
 }
--=20
2.26.2




On Wed, 2022-10-05 at 10:13 +0200, Otto Hollmann wrote:
> Hi Steve
>=20
> 1) I tested various combinations of ip_local_port_range and
> ip_local_reserved_ports, including edge cases like
> ip_local_port_range
> equal to ip_local_reserved_ports. In all such tests library behaved
> as
> expected. Let me know if I should test anything else.
>=20
> No, not yet. We wanted to firstly open discussion, but now we can add
> this patch into our distribution.
>=20
> 2) You are right, there is no reason why it shouldn't be declared as
> static. Should I send updated patch or you will do this minor
> modification yourself?
>=20
>=20
> Otto
>=20
> On Thu, 2022-07-14 at 13:01 -0500, Steve Dickson wrote:
> > Hey,
> >=20
> > My apologies for taking so long to get to this...
> >=20
> > A couple questions:
> >=20
> > 1) How well was tested... Is in your distro already?
> > 2) Those new functions the patch introduces...
> > =C2=A0=C2=A0=C2=A0 Don't effect the API? Meaning shouldn't they
> > =C2=A0=C2=A0=C2=A0 declared as static?
> >=20
> > steved.
> >=20
> > On 6/9/22 4:26 AM, Otto Hollmann wrote:
> > > Read reserved ports from
> > > /proc/sys/net/ipv4/ip_local_reserved_ports,
> > > store them into bit-wise array and before binding to random port
> > > check
> > > if port is not reserved.
> > >=20
> > >=20
> > > Currently, there is no way how to reserve ports so then will not
> > > be
> > > used by rpcbind.
> > >=20
> > > Random ports are opened by rpcbind because of rmtcalls. There is
> > > compile-time flag for disabling them, but in some cases we can
> > > not
> > > simply disable them.
> > >=20
> > > One solution would be run time option --enable-rmtcalls as
> > > already
> > > discussed, but it was rejected. So if we want to keep rmtcalls
> > > enabled
> > > and also be able to reserve some ports, there is no other way
> > > than
> > > filtering available ports. The easiest and clearest way seems to
> > > be
> > > just respect kernel list of ip_reserved_ports.
> > >=20
> > > Unfortunately there is one known disadvantage/side effect - it
> > > affects
> > > probability of ports which are right after reserved ones. The
> > > bigger
> > > reserved block is, the higher is probability of selecting
> > > following
> > > unreserved port. But if there is no reserved port, impact of this
> > > patch
> > > is minimal/none.
> > >=20
> > > Signed-off-by: Otto Hollmann <otto.hollmann@suse.com>
> > > ---
> > > =C2=A0 src/binddynport.c | 107
> > > ++++++++++++++++++++++++++++++++++++++++++----
> > > =C2=A0 1 file changed, 99 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/src/binddynport.c b/src/binddynport.c
> > > index 062629a..6f78ebe 100644
> > > --- a/src/binddynport.c
> > > +++ b/src/binddynport.c
> > > @@ -37,6 +37,7 @@
> > > =C2=A0 #include <unistd.h>
> > > =C2=A0 #include <errno.h>
> > > =C2=A0 #include <string.h>
> > > +#include <syslog.h>
> > > =C2=A0=20
> > > =C2=A0 #include <rpc/rpc.h>
> > > =C2=A0=20
> > > @@ -56,6 +57,84 @@ enum {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NPORTS=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D ENDPORT - LOWPORT + 1,
> > > =C2=A0 };
> > > =C2=A0=20
> > > +/*
> > > + * This function decodes information about given port from
> > > provided array and
> > > + * return if port is reserved or not.
> > > + *
> > > + * @reserved_ports an array of size at least "NPORTS /
> > > (8*sizeof(char)) + 1".
> > > + * @port port number within range LOWPORT and ENDPORT
> > > + *
> > > + * Returns 0 if port is not reserved, non-negative if port is
> > > reserved.
> > > + */
> > > +int is_reserved(char *reserved_ports, int port) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0port -=3D LOWPORT;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (port < 0 || port >=3D =
NPORTS)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return reserved_ports[port=
/(8*sizeof(char))] &
> > > 1<<(port%(8*sizeof(char)));
> > > +}
> > > +
> > > +/*
> > > + * This function encodes information about given *reserved* port
> > > into provided
> > > + * array. Don't call this function for ports which are not
> > > reserved.
> > > + *
> > > + * @reserved_ports array TODO .
> > > + * @port port number within range LOWPORT and ENDPORT
> > > + *
> > > + */
> > > +void set_reserved(char *reserved_ports, int port) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0port -=3D LOWPORT;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (port < 0 || port >=3D =
NPORTS)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reserved_ports[port/(8*siz=
eof(char))] |=3D
> > > 1<<(port%(8*sizeof(char)));
> > > +}
> > > +
> > > +/*
> > > + * Parse local reserved ports obtained from
> > > + * /proc/sys/net/ipv4/ip_local_reserved_ports into bit array.
> > > + *
> > > + * @reserved_ports a zeroed array of size at least
> > > + * "NPORTS / (8*sizeof(char)) + 1". Will be used for bit-wise
> > > encoding of
> > > + * reserved ports.
> > > + *
> > > + * On each call, reserved ports are read from /proc and bit-wise
> > > stored into
> > > + * provided array
> > > + *
> > > + * Returns 0 on success, -1 on failure.
> > > + */
> > > +
> > > +int parse_reserved_ports(char *reserved_ports) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int from, to;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char delimiter =3D ',';
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int res;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0FILE * file_ptr =3D
> > > fopen("/proc/sys/net/ipv4/ip_local_reserved_ports","r");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (file_ptr =3D=3D NULL) =
{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(void) syslog(LOG_ERR,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"Un=
able to open open
> > > /proc/sys/net/ipv4/ip_local_reserved_ports.");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if ((res =3D fscanf(file_ptr, "%d", &to)) !=3D 1) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(res =3D=3D EOF) break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0got=
o err;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (delimiter !=3D '-') {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fro=
m =3D to;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0for (int i =3D from; i <=3D to; ++i) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set=
_reserved(reserved_ports, i);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} while ((res =3D fscanf(f=
ile_ptr, "%c", &delimiter)) =3D=3D
> > > 1);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (res !=3D EOF)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fclose(file_ptr);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > +err:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(void) syslog(LOG_ERR,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"An error occurred while parsing
> > > ip_local_reserved_ports.");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fclose(file_ptr);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> > > +}
> > > +
> > > =C2=A0 /*
> > > =C2=A0=C2=A0 * Bind a socket to a dynamically-assigned IP port.
> > > =C2=A0=C2=A0 *
> > > @@ -81,7 +160,8 @@ int __binddynport(int fd)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0in_port_t port, *port=
p;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sockaddr *sap;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0socklen_t salen;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, res;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, res, array_size;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *reserved_ports;
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (__rpc_sockisbound=
(fd))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > @@ -119,21 +199,32 @@ int __binddynport(int fd)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0gettimeofday(&tv, NULL);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0seed =3D tv.tv_usec * getpid();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array_size =3D NPORTS / (8=
*sizeof(char)) + 1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reserved_ports =3D malloc(=
array_size);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!reserved_ports) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(reserved_ports, 0, =
array_size);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0parse_reserved_ports(reser=
ved_ports);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0port =3D (rand_r(&see=
d) % NPORTS) + LOWPORT;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < NPO=
RTS; ++i) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0*portp =3D htons(port++);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0res =3D bind(fd, sap, salen);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (res >=3D 0) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res=
 =3D 0;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bre=
ak;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0*portp =3D htons(port);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (!is_reserved(reserved_ports, port++)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res=
 =3D bind(fd, sap, salen);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(res >=3D 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(errno !=3D EADDRINUSE)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (errno !=3D EADDRINUSE)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bre=
ak;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (port > ENDPORT)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
port =3D LOWPORT;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0 out:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0free(reserved_ports);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&port_lo=
ck);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return res;
> > > =C2=A0 }
> >=20
>=20

