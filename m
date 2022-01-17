Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822154911B6
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 23:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiAQW1I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 17:27:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56380 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiAQW1H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 17:27:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2C0E21136;
        Mon, 17 Jan 2022 22:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642458426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYCim1vGevTbV8YNVDWcdYleiJk84qMyhh9CBSJLOoc=;
        b=vHTj0MErHpMxGiApwH+La77sh64bNBYzCO5b79YjMdTeftSBqtqmx1B6sB9ecS2DrKpdK1
        x08iq3LcUIS/m7cDPPzH7H4CV7lbZOXsUnxHQYB3x9fI4aa4AijB3XCBvTNXtvY4hwE9Rv
        Y9aBT6v6OclHLO5ZjPu8U+tAeHPJZyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642458426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYCim1vGevTbV8YNVDWcdYleiJk84qMyhh9CBSJLOoc=;
        b=3uPXMScW98cWEpQXWmyrE4og/9VtckkmnZ3fyDb+29i1NALtsYTHsR9OMdqBvJ4dlz1Xkd
        lp93vwyq+bnKWwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A8A313E95;
        Mon, 17 Jan 2022 22:27:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gJkWMjjt5WHEAQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 17 Jan 2022 22:27:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
Cc:     "'bfields@fieldses.org'" <bfields@fieldses.org>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: RE: client caching and locks
In-reply-to: =?utf-8?q?=3COSZPR01MB7050A3B0D15D38420532CD31EF579=40OSZPR01MB?=
 =?utf-8?q?7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: <20201001214749.GK1496@fieldses.org>,
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>,
 <20201006172607.GA32640@fieldses.org>,
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>,
 <20220103162041.GC21514@fieldses.org>, =?utf-8?q?=3COSZPR01MB7050F9737016E8?=
 =?utf-8?q?E3F0FD5255EF4A9=40OSZPR01MB7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom?=
 =?utf-8?q?=3E=2C?=
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>,
 <20220104153205.GA7815@fieldses.org>,
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>, 
 =?utf-8?q?=3COSZPR01MB7050C5098D47514FFEC2DA82EF4B9=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <20220105220353.GF25384@fieldses.org>,
 <164176553564.25899.8328729314072677083@noble.neil.brown.name>, =?utf-8?q??=
 =?utf-8?q?=3COSZPR01MB7050A3B0D15D38420532CD31EF579=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E?=
Date:   Tue, 18 Jan 2022 09:27:02 +1100
Message-id: <164245842205.24166.5326728089527364990@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 17 Jan 2022, inoguchi.yuki@fujitsu.com wrote:
> > 1/ If a client opens a file for write but does not get a delegation, and
> >    then writes to the file, then when it closes the file it *must*
> >    invalidate any cached data as there could have been a concurrent
> >    write from another client which is not visible in the changeid
> >    information. CTO consistency rules allow the client to keep cached
> >    data up to the close.
> > 2/ If a client opens a file for write and *does* get a delegation, then
> >    providing it gets a changeid from the server after final write and
> >    before returning the delegation, it can keep all cached data (until
> >    the server reports a new changeid).
> >
> > Note that the inability to cache in '1' *should* *not* be a performance
> > problem in practice.
> > a/ if locking is used, cached data is not trusted anyway, so no loss
>=20
> How about the case for using whole-file lock?
> I'm assuming that cached data is trusted in this case, so it could be a per=
formance problem, couldn't it?=20

I don't think that case adds anything interesting.  When the file is
closed, the lock is dropped.  If there were any writes without a
delegation, then the changeid isn't a reliable indication that no other
client wrote.  So the cache must be dropped.

NeilBrown


>=20
> Yuki Inoguchi
>=20
