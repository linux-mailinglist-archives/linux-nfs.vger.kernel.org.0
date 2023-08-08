Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF0774D40
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjHHVpO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 17:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHHVpN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 17:45:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C03B196
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 14:45:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A2D9C1F45E;
        Tue,  8 Aug 2023 21:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691531111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKjhLOxoWxXOMMJACQ64J1EucwRhDwcUHmIYM1hZnNA=;
        b=y2vRLC84OPonpgiuJkUPDCUiFs/MKqAiIpJB5+j/oCgfb4SQKbcVCjQszVHOl/V9c2SqN/
        3xWNcpOkrNKxw2Yk5Rz6LoRgSqVidY3esVFyI1qNGZEc34XuHECGKIexZjZC5eXJQivNV1
        b1tl/C78j9g0+sqb0+tvDRXbtzC6kQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691531111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKjhLOxoWxXOMMJACQ64J1EucwRhDwcUHmIYM1hZnNA=;
        b=Akx+PTDuFp+t56BN636RYtQj0BHL6HQ28/0y1xYRZ8kodZIZF88yhz+ZIq5Z+NewD4p81w
        qpsL8NpEMLhP8qAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD059139D1;
        Tue,  8 Aug 2023 21:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EDvfG2W30mQOcwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 08 Aug 2023 21:45:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
In-reply-to: <ZNJctyaMBVuoT6yz@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>,
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>,
 <ZNJCIRjI64YIY+I0@tissot.1015granger.net>,
 <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>,
 <ZNJLQIxweTaEsu16@tissot.1015granger.net>,
 <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>,
 <ZNJctyaMBVuoT6yz@tissot.1015granger.net>
Date:   Wed, 09 Aug 2023 07:45:06 +1000
Message-id: <169153110624.32308.3596310364486971122@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 09 Aug 2023, Chuck Lever wrote:
> On Tue, Aug 08, 2023 at 10:20:44AM -0400, Jeff Layton wrote:
> > 
> > It would probably be fairly simple to output well-formed yaml instead.
> > JSON and XML are a bit more of a pain.
> 
> If folks don't mind, I would like more structured output like one of
> these self-documenting formats. (I know I said I didn't care before,
> but I'm beginning to care now ;-)

Lustre, which I am somewhat involved with, uses YAML for various things.
If someone else introduced yaml-producing sysfs files to the kernel
first, that might make the path for lustre smoother :-)

Another option is netlink which lustre is stating to use for
configuration and stats.  It is a self-describing format.  The code
looks verbose, but it is widely used in the kernel and so well supported.

> 
> I'm also wondering if we really ought not add another file under
> /proc, which is essentially obsolete. Would /sys/fs/nfsd/yada be
> better for this facility?

It is only under /proc because that is where it is mounted by default :-)
I think it might be sensible to create a node under /sys where all the
content of the nfsd filesystem also appears.
I'm not keen on /sys/fs/nfsd because nfsd isn't a filesystem, it is a
service.
But the /sys/fs seems to be largely unstructured (/proc v2??) so maybe
putting nfsd there is OK.  We could claim that /proc/fs/nfsd is a
filesystem :-)

> 
> I hesitate to even mention network namespaces...

Please do mention them - I find them too easy to forget about.
/proc/fs/nfsd/ inherits the network namespace from whoever mounts it.
So this can work perfectly.
If we created a mirror in /sys/ we would presumably use the namespace of
the process that opens the file.

Thanks,
NeilBrown
