Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039943F9407
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 07:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbhH0F2I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 01:28:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244208AbhH0F2E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 01:28:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DF6C2235A;
        Fri, 27 Aug 2021 05:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630042034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+SXcB3iWGcJ6WSl0nFLyyOQoheMXVbyhqDHRHvXp7c=;
        b=x4Nzqud/1Ip1ABMTokMskt5Fs8t6BKRK7+Q0m9Esd3IsjwLyNsIDlJO9/sTobp/xoQ2+NX
        rNppRYNj3ioOFI4tEI2UT2KTih3utuUHrD7ftHKztjIiriF8gi4sY0PzPbzlBbgNyw3lLw
        49HH/sdQ8D+tECe5XawxSXimUhLN25k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630042034;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+SXcB3iWGcJ6WSl0nFLyyOQoheMXVbyhqDHRHvXp7c=;
        b=lPIrzaiX23yq24N0SkdCPoMk0O23zJLN0+qgf8M0aLMzgECoP4ZcFmapIAYW2J7oxPZEXG
        Y/ShMFtrQUGq1FBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0EDB13D1E;
        Fri, 27 Aug 2021 05:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dSdVK7B3KGG/MQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Aug 2021 05:27:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>,
        Mel Gorman <mgorman@suse.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com>
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
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>,
 <163001427749.7591.7281634750945934559@noble.neil.brown.name>,
 <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com>
Date:   Fri, 27 Aug 2021 15:27:09 +1000
Message-id: <163004202961.7591.12633163545286005205@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


[[Mel: if you read through to the end you'll see why I cc:ed you on this]]

On Fri, 27 Aug 2021, Mike Javorski wrote:
> I just tried the same mount with 4 different nfsvers values: 3, 4.0, 4.1 an=
d 4.2
>=20
> At first I thought it might be "working" because I only got freezes
> with 4.2 at first, but I went back and re-tested (to be sure) and got
> freezes with all 4 versions. So the nfsvers setting doesn't seem to
> have an impact. I did verify at each pass that the 'nfsvers=3D' value
> was present and correct in the mount output.
>=20
> FYI: another user posted on the archlinux reddit with a similar issue,
> I suggested they try with a 5.12 kernel and that "solved" the issue
> for them as well.

well... I have good news and I have bad news.

First the good.
I reviewed all the symptoms again, and browsed the commits between
working and not-working, and the only pattern that made any sense was
that there was some issue with memory allocation.  The pauses - I
reasoned - were most likely pauses while allocating memory.

So instead of testing in a VM with 2G of RAM, I tried 512MB, and
suddenly the problem was trivial to reproduce.  Specifically I created a
(sparse) 1GB file on the test VM, exported it over NFS, and ran "md5sum"
on the file from an NFS client.  With 5.12 this reliably takes about 90 secon=
ds
(as it does with 2G RAM).  On 5.13 and 512MB RAM, it usually takes a lot
longer.  5, 6, 7, 8 minutes (and assorted seconds).

The most questionable nfsd/ memory related patch in 5.13 is

 Commit f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator")

I reverted that and now the problem is no longer there.  Gone.  90seconds
every time.

Now the bad news: I don't know why.  That patch should be a good patch,
with a small performance improvement, particularly at very high loads.
(maybe even a big improvement at very high loads).
The problem must be in alloc_pages_bulk_array(), which is a new
interface, so not possible to bisect.

So I might have a look at the code next week, but I've cc:ed Mel Gorman
in case he comes up with some ideas sooner.

For now, you can just revert that patch.

Thanks for all the testing you did!!  It certainly helped.

NeilBrown

