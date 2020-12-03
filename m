Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA62CE2AE
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 00:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgLCX3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 18:29:40 -0500
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:59798 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbgLCX3k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 18:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1607038179; bh=PJDrxgTryL2xoYDKehnbEMA4dH8y2FKxHB80
        IeeSl2o=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=gX/X9CNtZLm9fCEStpzORB8nc8Dm+sH8R8CURuzxHz+20O
        68QerRE1ffmsWN8H7L9I8qCsyE6klcak8SYtU+u5f30bD17ndvg/ymKz8mumQ2j17OF
        fCuNK3IoT9mrTEQX3piNoXqM/xmsuveO9EGbyQ5OLTuOqF6dqkM4nZ6fBYg14Px79at
        DsOXcGpTnkEd5WdLgZsjbzlT/zdgH4pg1/rs0lvZS6sTwID5H/mxs7y6Ga698FprUZB
        011pGsn/ArO4ZtY+V/IwyWaMsJ4G0rnEy9MfZrE2bjFBVQWHsmTY8dVM9QYGcPUDRIU
        83RTchLutM4PvLnBvTR4Mz9gw1kw==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=b/mAHYPQs5849ih8S5Su/j57f/pULN7oEsgLa58O8LryxLlZtEVsUt+eIo4UaH4Iq72Fvsr15jfXTETPpSNUtndXk/SQHFqMmulIz29j+kRvmlGpHsrHwDCGlOdTbTTtpD00Wx+j/ujn9yE9MFrNkTwk0iRoQ1rObYUyNSJNUAm3aXEiP++rfiKgl5w2oyr8c5vWOwhfgBPPeRQz4gOSMpeRFMcFzXKbZMd6A4mSqxXj+u1UPffKxuHfw8vsPROjmPhqp1tZRzRF//yLHATwwgh0lz6SyAhF8m1xKtXmHPwymQQu2z1Frn0S2zTvD53T2vkU9u5UXZr7iqVzoPoscA==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1kky1v-0006vq-NO; Thu, 03 Dec 2020 18:28:55 -0500
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     <bfields@fieldses.org>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>
Cc:     <linux-cachefs@redhat.com>, <linux-nfs@vger.kernel.org>,
        <daire@dneg.com>
References: <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com> <20201124211522.GC7173@fieldses.org> <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com> <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com> <20201203185109.GB27931@fieldses.org> <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com> <20201203211328.GC27931@fieldses.org> <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com> <20201203224520.GG27931@fieldses.org> <d88c69f90820bf631908cbe3d3ce34343ec672f1.camel@hammerspace.com> <20201203231655.GH27931@fieldses.org>
In-Reply-To: <20201203231655.GH27931@fieldses.org>
Subject: RE: Adventures in NFS re-exporting
Date:   Thu, 3 Dec 2020 15:28:54 -0800
Message-ID: <01ad01d6c9cc$11a6e530$34f4af90$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQGLCl71o/mllkcOM8ZTKfem/khTDAJjSqDGAjc9/isC5PHtZAIjFAJ1Aky2llQCn/rUrgIxRIQHAlROta8CY9Hk3wEcSJ+Bqcjbo/A=
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d00eb943d3b1620205d5b2bf3e3d4f8ac350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Thu, Dec 03, 2020 at 10:53:26PM +0000, Trond Myklebust wrote:
> > On Thu, 2020-12-03 at 17:45 -0500, bfields@fieldses.org wrote:
> > > On Thu, Dec 03, 2020 at 09:34:26PM +0000, Trond Myklebust wrote:
> > > > I've been wanting such a function for quite a while anyway in
> > > > order to allow the client to detect state leaks (either due to
> > > > soft timeouts, or due to reordered close/open operations).
> > >
> > > One sure way to fix any state leaks is to reboot the server.  The
> > > server throws everything away, the clients reclaim, all that's =
left
> > > is stuff they still actually care about.
> > >
> > > It's very disruptive.
> > >
> > > But you could do a limited version of that: the server throws away
> > > the state from one client (keeping the underlying locks on the
> > > exported filesystem), lets the client go through its normal =
reclaim
> > > process, at the end of that throws away anything that wasn't
> > > reclaimed.  The only delay is to anyone trying to acquire new =
locks
> > > that conflict with that set of locks, and only for as long as it
> > > takes for the one client to reclaim.
> >
> > One could do that, but that requires the existence of a quiescent
> > period where the client holds no state at all on the server.
>=20
> No, as I said, the client performs reboot recovery for any state that =
it holds
> when we do this.

Yea, but the original sever goes through a period where it has dropped =
all state and isn't in grace, and if it's coordinating with non-NFS =
users, they don't know anything about grace anyway.

Frank

