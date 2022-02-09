Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C954AE6B2
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 03:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiBICkM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 21:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242813AbiBIBZG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 20:25:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3232AC061576
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 17:25:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C30071F390;
        Wed,  9 Feb 2022 01:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644369903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xoW8U8zcEYvAqQoD9FkpsjPntqyxVzO40+GN+Jmlz1M=;
        b=cQCvJSgfGTONdvdDa00vfhvi345AEOFYY1a6E0btXrDNQeVO24bvNy0CjShhVEFTO3/eUu
        w9Z62BoAVe7k+oXpxPaLxrQoPR4PWSuzcd+2+m8tHlGNSMC2oXpa3LW/3v5xjDOhOV1oOy
        PSImIzQuerVCCJyfwCjMyL5ndGmiTec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644369903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xoW8U8zcEYvAqQoD9FkpsjPntqyxVzO40+GN+Jmlz1M=;
        b=edzngP+IRICeStiIoPshdK3OI9jdJBACsTfBm7UnxRPZfx8mFxe8UWW7prUFzflKvk3XKw
        ofKRZq7aLIaKODAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6009132DB;
        Wed,  9 Feb 2022 01:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o58WGO4XA2JvEQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 09 Feb 2022 01:25:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
In-reply-to: <06e2a692e587d1ffcccd14d465136df228149e4c.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>,
 <164428557862.27779.17375354328525752842@noble.neil.brown.name>,
 <A677D8A9-FD0B-43E5-82D6-E660CCB8B185@redhat.com>,
 <164435376000.27779.4059629372785561121@noble.neil.brown.name>,
 <06e2a692e587d1ffcccd14d465136df228149e4c.camel@hammerspace.com>
Date:   Wed, 09 Feb 2022 12:24:59 +1100
Message-id: <164436989902.27779.4490909869062483924@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 09 Feb 2022, Trond Myklebust wrote:
> On Wed, 2022-02-09 at 07:56 +1100, NeilBrown wrote:
> > 
> > So I still STRONGLY think that the identity should be set by
> > mount.nfs
> > reading (and writing) some file in /etc or /etc/netnfs/NAME, and I
> > weakly think that the file should be in /etc/nfs.conf.d/ so that the
> > reading is automagic.
> > 
> 
> No. It's not a per-mount setting, so it has no business being in the
> mount protocol.

I agree that it is not different for different mounts, but every mount
needs it, and without any mounts it is not needed.

Much like statd really, which is started by mount.nfs when it is
determined that it is needed, but not running.

NeilBrown
