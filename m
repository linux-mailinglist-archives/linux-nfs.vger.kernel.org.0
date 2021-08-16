Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5DD3EE02B
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Aug 2021 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhHPXC3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 19:02:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhHPXC3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 19:02:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A96451FEF7;
        Mon, 16 Aug 2021 23:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629154916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YsIyaZDokLDG69CTI5q/xe/0p6vhrTmhJWh2BmxnoI=;
        b=UXmDFfhqFQVgn1tSi2twIrvcHC92QC4yU19OZD9Bx18FQNxjCJX5+4fThF9HBx69eQRa5j
        dJ2PHTCK3mOHcXjXeXoVA03L4q/zdTjX9/NZ4h8rrg4dBBQM2+0o23lxbryQTDy1oVzvWM
        1JuRJN0VMWOzktAuL4xzo7XN/iLlRW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629154916;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YsIyaZDokLDG69CTI5q/xe/0p6vhrTmhJWh2BmxnoI=;
        b=oEH9W3YbKRNV1qLhCK+hg5EiRpat+FGohWOCrbzAIY+1NrHQ79NhbahMUKmViFdaL/zfKY
        T0Ri1BppRdmKYVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9735A13DDB;
        Mon, 16 Aug 2021 23:01:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9YDHFGPuGmFWLAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 16 Aug 2021 23:01:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
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
 <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
Date:   Tue, 17 Aug 2021 09:01:52 +1000
Message-id: <162915491276.9892.7049267765583701172@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 17 Aug 2021, Mike Javorski wrote:
> Thanks for the pointer Chuck
>=20
> I ran the trace capture and was able to trigger two freezes in
> relatively short order. Here is that trace file:
> https://drive.google.com/file/d/1qk_VIMkj8aTeQIg5O0W3AvWyeDSWL3vW/view?usp=
=3Dsharing
>=20

There are gaps of 5.3sec, 4sec, 1sec and 1sec between adjacent trace
points.
The longest gap between 'start' and 'done' for any given xid is 354msec.
So it doesn't look like the filesystem read causing the problem.

The long gaps between adjacent records are:
0.354581 xid=3D0x4c6ac2b6
0.418340 xid=3D0x6a71c2b6
1.013260 xid=3D0x6f71c2b6
1.020742 xid=3D0x0f71c2b6
4.064527 xid=3D0x6171c2b6
5.396559 xid=3D0xd66dc2b6

The fact 1, 1, and 4 are so close to a precise number of seconds seems
unlikely to be a co-incidence.  It isn't clear what it might mean
though.

I don't have any immediae ideas where to look next.  I'll let you know
if I come up with something.

NeilBrown
