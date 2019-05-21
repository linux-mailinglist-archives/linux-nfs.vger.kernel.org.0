Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D45252AA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 16:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfEUOtg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 10:49:36 -0400
Received: from fieldses.org ([173.255.197.46]:57812 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbfEUOtg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 May 2019 10:49:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A4AC51C81; Tue, 21 May 2019 10:49:35 -0400 (EDT)
Date:   Tue, 21 May 2019 10:49:35 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Xuewei Zhang <xueweiz@google.com>, jlayton@kernel.org,
        Grigor Avagyan <grigora@google.com>,
        Trevor Bourget <bourget@google.com>,
        Nauman Rafique <nauman@google.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] lockd: Show pid of lockd for remote locks
Message-ID: <20190521144935.GB9499@fieldses.org>
References: <CAPtwhKrJw54DmfVdP4ADd3w5QPv0cRP+kr1Atn58QOFL5xBGbA@mail.gmail.com>
 <3A924C3F-A161-4EE2-A74E-2EE1B6D2CA14@redhat.com>
 <CAPtwhKoF0XTuFa5msGB_eiiwRcJA0kK7eu6Rw6-b-5+8Qy0DDw@mail.gmail.com>
 <C5CB1B1E-59BD-4DB6-82D8-CE8E641CAC5A@redhat.com>
 <FF6B465E-DA4C-430D-ABEE-6053EF1E9A44@redhat.com>
 <20190520205106.GA29025@fieldses.org>
 <C3DA91E7-B905-4A74-94A0-2BF4AFE1FD05@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C3DA91E7-B905-4A74-94A0-2BF4AFE1FD05@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 21, 2019 at 07:18:57AM -0400, Benjamin Coddington wrote:
> On 20 May 2019, at 16:51, J. Bruce Fields wrote:
> 
> >On Mon, May 20, 2019 at 10:22:00AM -0400, Benjamin Coddington wrote:
> >>Ok, I just noticed that we set fl_owner to the nlm_host in
> >>nlm4svc_retrieve_args, so things are not as dire as I thought.  What
> >>would be nice is a sane set of tests for NLM..
> >
> >What would we have needed to catch this?  Sounds like it turns
> >multi-client testing wouldn't have been required?  (Not that that
> >would
> >be a bad idea.)
> 
> Two NLM clients would be ideal to exercise the full range of
> expected lock behavior.  I suspect that's something I can do with
> what's in pynfs today, but I haven't looked yet.  I suppose if
> there's a test for NLM I should make one for v4 too..

There isn't any pynfs NLM code.  Some isilon folks did NLM/NSM/NFSv2/v3
pynfs tests:

	https://github.com/sthaber/pynfs

I just never got a chance to incorporate them and try them.  It's been a
while, and I think there were one or two odd things about it, but maybe
it'd be a good starting point.

--b.
