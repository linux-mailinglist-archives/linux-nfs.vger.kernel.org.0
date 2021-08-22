Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EB93F41D6
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 00:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhHVWBR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Aug 2021 18:01:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50220 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhHVWBQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Aug 2021 18:01:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AEBA221B81;
        Sun, 22 Aug 2021 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629669633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufHO4KwvSXwyG1ay4KSihhLFkSzwIIgYaiY6y/rU7A0=;
        b=E96615qLGX9Rcg49EsLlwFSJsJ9S361TrjcfCezKTro7a5egX87X/Cu1uWvzWtasmSU1sb
        tx6q0HBL5c8Wiix7P/1CPqej66QewdIU4bG9sv488boEOOgMWhje4L0SWfohHwZHYecJe8
        N6s3i4R8t3qXA21M+Ukh8Q7eSXKEZ7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629669633;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufHO4KwvSXwyG1ay4KSihhLFkSzwIIgYaiY6y/rU7A0=;
        b=1LpN77HRhgwejRnWLdpa6HYG9+5G5f3dZzyxaxrfgALf3jdsLK1o59d+wDquq1E9nmO1Se
        yCKLOrCL3KZji/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9172513A9E;
        Sun, 22 Aug 2021 22:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EM3iEwDJImFtbAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 22 Aug 2021 22:00:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>,
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>,
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>,
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>,
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>,
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>,
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>,
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>,
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>,
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>,
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>,
 <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>,
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>,
 <162941948235.9892.6790956894845282568@noble.neil.brown.name>,
 <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>,
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>,
 <162960371884.9892.13803244995043191094@noble.neil.brown.name>,
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>
Date:   Mon, 23 Aug 2021 08:00:27 +1000
Message-id: <162966962721.9892.5962616727949224286@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 22 Aug 2021, Mike Javorski wrote:
> 5.12.15-arch1:
> ===============
> 14723 137 0.00921938
> 
> 5.13.12-arch1: (no freezes)
> ===============
> 15333 206 0.013257
> 
> 5.13.12-arch1: (with freezes)
> ===============
> 9230 299 0.0313779
> 
> So a decent bump w/ 5.13, and even more with the freezes.

Thanks.  9->13 isn't as much as I was hoping for, but it might still be
significant. 

> This machine is an older Opteron server w/ nforce networking. Not sure
> how much offloading it actually does.

The tcpdump showed the server sending very large packets, which means
that it is at least doing TCP segmentation offload and checksum offload.
Those are very common these days.

Thanks,
NeilBrown
