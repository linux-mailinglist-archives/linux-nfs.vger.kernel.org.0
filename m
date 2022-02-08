Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F3D4ACF81
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 04:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiBHDO3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 22:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiBHDO2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 22:14:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C736BC061A73
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 19:14:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6EAB8210E7;
        Tue,  8 Feb 2022 03:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644290066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/AJa5qSWaqPmu1iAww1/sTJr+2fXYVMaMjeBsN1aOI=;
        b=QEuey581SWmUYx/bdOMJcpNT+zUh4J044zQdbhwEaR1X0wZa0F8Onva+c++wf5uztflvAC
        SS8Q672zQB8Zv4+OQgC1M1eHiAonFasFS2ixr81hdVXE4HPpBS0pwTItzEQY/6Y1l9cmnM
        7r20Ky7FJlbQcob0CE+qPp9hT1kmIFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644290066;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/AJa5qSWaqPmu1iAww1/sTJr+2fXYVMaMjeBsN1aOI=;
        b=Am6pSGny8VpxsoleJX6/9pOKi5G00J9QKsGYrNzOH3o0ap8AIYjb62R1PBBvUmtLkE6/nr
        7ak+xrunxV8jy2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FF5213BA0;
        Tue,  8 Feb 2022 03:14:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D337LhDgAWKIXAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 08 Feb 2022 03:14:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Benjamin Coddington" <bcodding@redhat.com>,
        "Steve Dickson" <steved@redhat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
In-reply-to: <26803BBB-4F2C-4EFD-BC8D-A50A5C361E5C@oracle.com>
References: =?utf-8?q?=3Cc2e8b7c06352d3cad3454de096024fff80e638af=2E16439791?=
 =?utf-8?q?61=2Egit=2Ebcodding=40redhat=2Ecom=3E=2C?=
 <87EAC6F6-C450-4642-A11A-55247C791D66@oracle.com>,
 <32889B9A-1293-4050-8131-726042D1EAD9@redhat.com>,
 <26803BBB-4F2C-4EFD-BC8D-A50A5C361E5C@oracle.com>
Date:   Tue, 08 Feb 2022 14:14:21 +1100
Message-id: <164429006120.27779.2597672223372340780@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 05 Feb 2022, Chuck Lever III wrote:
> 
> The problem is that a network namespace (to which the persistent
> uniquifier is attached) and an FS namespace (in which the persistent
> uniquifier is stored) are created and managed independently.

Not necessarily ....  at least: network namespaces do have visibility in
the filesystem and you can have files that associate with a specific
network namespace - without depending on FS namespaces.

"man ip-netns" tells us that when a tool (e.g.  mount.nfs) is
network-namespace aware, it should first look in /etc/netns/NAME/
before looking in /etc/ for any config file.
The tool can determine "NAME" by running "ip netns identify", but there
is bound to library code to achieve the same effect.
You stat /proc/self/ns/net, then readdir /run/netns and stat everything
in there until you find something that matches /proc/self/ns/net

If a container management system wants to put /etc/ elsewhere, it can
doubtlessly install a symlink in /etc/netns/NAME, and as this is an
established standard, it seems likely that they already do.

So: enhance nfs-utils config code to (optionally) look in
/etc/netns/NAME first (or maybe last if they are to override) , and
store the identity in /etc/{netns/NAME/}nfs.conf.d/identity.conf

Whatever tool creates the identity, writes it to
  /etc/netns/NAME/nfs.conf.d/identity.conf

While we are at it, we should get exportfs to look there too, and
establish some convention so /var/lib/nfs can use a different path in
different network namespaces.

Thanks,
NeilBrown


> 
> We need to agree on how NFSv4 clients in containers are to be
> supported before the proposed tool can be evaluated fully.
> 
> 
> --
> Chuck Lever
> 
> 
> 
> 
