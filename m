Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774673F9040
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 23:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbhHZVpa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 17:45:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbhHZVpa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 17:45:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7ACD6221EA;
        Thu, 26 Aug 2021 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630014281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/oLVzbc2H14966at54gRBqlUl/kxEb0uqojyuENTrg=;
        b=PBfzYgDe3/YnM5ea7JAMc0+9WL7XMjWTO8FDIL6q2zvJv7pUBIb0vA+j7CL3FGWa6yo+Wc
        n5dt76ZgPi8vwAAysTUtDAV+OjlrVnOgr1M19IlGnmZvlxgdxSDR6PWfdTyrZXDf5r3oZ7
        LsNJ4OwUepoQxw/ZQID+xQh+pwkdcBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630014281;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/oLVzbc2H14966at54gRBqlUl/kxEb0uqojyuENTrg=;
        b=4itOS+W0a1N7vp7Ng9HKzwchNqbamkdaY4Gv8DGNWEfw6mceBovwvzmwqKb+YP4De2Utk+
        BHlx0Oq6JTrCQPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 699EB13CF8;
        Thu, 26 Aug 2021 21:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0AfcCUgLKGFVbQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 26 Aug 2021 21:44:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>
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
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>,
 <162966962721.9892.5962616727949224286@noble.neil.brown.name>,
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>
Date:   Fri, 27 Aug 2021 07:44:37 +1000
Message-id: <163001427749.7591.7281634750945934559@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 27 Aug 2021, Mike Javorski wrote:
> I finally had the chance to test with the offloading disabled on the
> server. Unfortunately, the issues remain, may even be more frequent,
> but I can't rule out confirmation bias on that one.
> 
> Not sure where to go from here.

Have you tried NFSv3?  Or 4.0?
I am (or was) leaning away from thinking it was an nfsd problem, but we
cannot rule anything out until we know that is happening.

I plan to have another dig through the code changes today.

NeilBrown
