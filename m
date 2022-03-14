Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B634D8632
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 14:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiCNNt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiCNNt4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 09:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5F7D36B67
        for <linux-nfs@vger.kernel.org>; Mon, 14 Mar 2022 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647265724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O2wBmXicfWmg+4WZUTIWZzMGW/aHax4YVk3xj7hia3w=;
        b=CN1ljfjfIxIx+5lNGWCutqIs/4Sur6sI+UJ0+OEhiJtF1X5rL239fm0jdjyhWJh4cjFoY/
        WSKrTDd4uqmvccDuwi4SSqRIa+wvjtghnEc0G29WN8yZ53KaCGMht6CG+HlIOedG8pyjzy
        n10AMZA3cePM08CB7G/2U01ppligPcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-HPkFMCyePda6r6AWQK1QJw-1; Mon, 14 Mar 2022 09:48:43 -0400
X-MC-Unique: HPkFMCyePda6r6AWQK1QJw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 414EA80088A;
        Mon, 14 Mar 2022 13:48:43 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8B0D697C8E;
        Mon, 14 Mar 2022 13:48:42 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     "Steve Dickson" <SteveD@RedHat.com>,
        "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Date:   Mon, 14 Mar 2022 09:48:42 -0400
Message-ID: <8EF0A369-CDE5-4FA1-9085-A6BB96C711C8@redhat.com>
In-Reply-To: <164721984672.11933.15475930163427511814@noble.neil.brown.name>
References: <164721984672.11933.15475930163427511814@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Mar 2022, at 21:04, NeilBrown wrote:

> When mounting NFS filesystem in a network namespace using v4, some 
> care
> must be taken to ensure a unique and stable client identity.  Similar
> case is needed for NFS-root and other situations.
>
> Add documentation explaining the requirements for the NFS identity in
> these situations.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>
> I think I've address most of the feedback, but please forgive and 
> remind
> if I missed something.
> NeilBrown
>
>  utils/mount/nfs.man | 109 
> +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
>
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index d9f34df36b42..5f15abe8cf72 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -1,7 +1,7 @@
>  .\"@(#)nfs.5"
>  .TH NFS 5 "9 October 2012"
>  .SH NAME
> -nfs \- fstab format and options for the
> +nfs \- fstab format and configuration for the
>  .B nfs
>  file systems
>  .SH SYNOPSIS
> @@ -1844,6 +1844,113 @@ export pathname, but not both, during a 
> remount.  For example,
>  merges the mount option
>  .B ro
>  with the mount options already saved on disk for the NFS server 
> mounted at /mnt.
> +.SH "NFS CLIENT IDENTIFIER"
> +NFSv4 requires that the client present a unique identifier to the 
> server
> +to be used to track state such as file locks.  By default Linux NFS 
> uses
> +the host name, as configured at the time of the first NFS mount,
> +together with some fixed content such as the name "Linux NFS" and the
> +particular protocol version.  When the hostname is guaranteed to be
> +unique among all client which access the same server this is 
> sufficient.
> +If hostname uniqueness cannot be assumed, extra identity information
> +must be provided.
> +.PP
> +Some situations which are known to be problematic with respect to 
> unique
> +host names include:
> +.IP \- 2
> +NFS-root (diskless) clients, where the DCHP server (or equivalent) 
> does
> +not provide a unique host name.
> +.IP \- 2
> +"containers" within a single Linux host.  If each container has a 
> separate
> +network namespace, but does not use the UTS namespace to provide a 
> unique
> +host name, then there can be multiple effective NFS clients with the
> +same host name.
> +.IP \= 2
> +Clients across multiple administrative domains that access a common 
> NFS
> +server.  If assignment of host name is devolved to separate domains,
> +uniqueness cannot be guaranteed, unless a domain name is included in 
> the
> +host name.
> +.SS "Increasing Client Uniqueness"
> +Apart from the host name, which is the preferred way to differentiate
> +NFS clients, there are two mechanisms to add uniqueness to the
> +client identifier.
> +.TP
> +.B nfs.nfs4_unique_id
> +This module parameter can be set to an arbitrary string at boot time, 
> or
> +when the
> +.B nfs
> +module is loaded.  This might be suitable for configuring diskless 
> clients.
> +.TP
> +.B /sys/fs/nfs/client/net/identifier
> +This virtual file (available since Linux 5.3) is local to the network
> +name-space in which it is accessed and so can provided uniqueness 
> between

+name-space in which it is accessed and so can provided uniqueness 
between
+name-space in which it is accessed and so can provide uniqueness 
between
                                                       ^

> +network namespaces (containers) when the hostname remains uniform.
> +.RS
> +.PP
> +This value is empty on name-space creation.
> +If the value is to be set, that should be done before the first
> +mount.  If the container system has access to some sort of 
> per-container
> +identity then that identity, possibly obfuscated as a UUID is privacy 
> is

+identity then that identity, possibly obfuscated as a UUID is privacy 
is
+identity then that identity, possibly obfuscated as a UUID if privacy 
is
                                                             ^^

> +needed, can be used.  Combining the identity with the name of the
> +container systems would also help.  For example:
> +.RS 4
> +echo "ip-netns:`ip netns identify`" \\
> +.br
> +   > /sys/fs/nfs/client/net/identifier
> +.br
> +uuidgen --sha1 --namespace @url  \\
> +.br
> +   -N "nfs:`cat /etc/machine-id`" \\
> +.br
> +   > /sys/fs/nfs/client/net/identifier
> +.RE
> +If the container system provides no stable name,
> +but does have stable storage, then something like
> +.RS 4
> +[ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid &&
> +.br
> +cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier
> +.RE
> +would suffice.
> +.PP
> +If a container has neither a stable name nor stable (local) storage,
> +then it is not possible to provide a stable identifier, so providing
> +a random identifier to ensure uniqueness would be best
> +.RS 4
> +uuidgen > /sys/fs/nfs/client/net/identifier
> +.RE
> +.RE
> +.SS Consequences of poor identity setting
> +Any two concurrent clients that might access the same server must 
> have
> +different identifiers for correct operation, and any two consecutive
> +instances of the same client should have the same identifier for 
> optimal
> +crash recovery.
> +.PP
> +If two different clients present the same identity to a server there 
> are
> +two possible scenarios.  If the clients use the same credential then 
> the
> +server will treat them as the same client which appears to be 
> restarting
> +frequently.  One client may manage to open some files etc, but as 
> soon
> +as the other client does anything the first client will lose access 
> and
> +need to re-open everything.
> +.PP
> +If the clients use different credentials, then the second client to
> +establish a connection to the server will be refused access.  For
> +.B auth=sys
> +the credential is based on hostname, so will be the same if the
> +identities are the same.  With
> +.B auth=krb
> +the credential is stored in
> +.I /etc/krb5.keytab
> +and will be the same only if this is copied among hosts.
> +.PP
> +If the identity is unique but not stable, for example if it is 
> generated
> +randomly on each start up of the NFS client, then crash recovery is
> +affected.  When a client shuts down uncleanly and restarts, the 
> server
> +will normally detect this because the same identity is presented with

There's ambiguity on "this", it could be the situation described in the
previous sentence, how about:

+will normally detect this because the same identity is presented with
+will normally detect the unclean restart because the same identity is 
presented with

Ben

