Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0678623AF
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390963AbfGHPhF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 11:37:05 -0400
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:50164 "EHLO
        elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387805AbfGHPhE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 11:37:04 -0400
X-Greylist: delayed 3099 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jul 2019 11:37:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1562600224; bh=4OOkiuwW8V+PTmDuE0Rwtkk4e0OTemcwL0jX
        WxFGceY=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=C0z2//PQwvAaPR5lqRpizInzKglW/6dkh1Hc8luZD8SArZ
        NxCvAHtSoYRTvQ/TwavKHuPTySwLhbXJa8WhjmTnQQOFReTjgF4k4YcI3s85WAEAKHK
        C4DLiWR2Jp4VvrYAf1kNRIZ7/Ij2zoNE92SRxokWvCdXBZPEr7HMzZ28g/avLgOs35s
        btDyzyXRKE9lGOtfzuoEcqeKU1m2jwmvk3O1kmx0FrrdAOHl9cvUYNScKnRPVDGZcYy
        7zT4Dkfer+lrCeV+imVmxwcYATnWXveqPWVQzpRtrEYT1wDWB0D1myMYjt87MHCjAdM
        cUNosdfQmfpY+UlHg9q5iogDV4Xg==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=JXJzGYy0XwS8OrUTBIxwMkvKRtlBpdq673OzRqva5mCmUHGdp1P9P0Ib92qgkWfvheVSo53Lz1YiTwhRKwboiNvGaEMXN50bfXgI9xN2xCUEmuTcR1Xa7JcCNySX3yH/cG2Mo4kAKh7MTH4B/sB1K2Sy9h0CHLW983hdds2IsoLDuo2kxJ9Y0W7KR5jSCuney13GHdQROTGxI9r4N+LNe8hAQm6uXkGZ8QlQzMSkKDrkgG924953js8O7bwk8TUDh7ixIjPkS2ZZ8NhmPKb7khFfR+eOuWGBDY4BqiMJ8v37dYbsLr4W6qLmYD6jCjUelFClhazSD82F9KobIQ1Zsw==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1hkUtQ-0008aX-Ai; Mon, 08 Jul 2019 10:45:24 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     <dang@redhat.com>, "'Su Yanjun'" <suyj.fnst@cn.fujitsu.com>
Cc:     <linux-nfs@vger.kernel.org>
References: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com> <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com> <89d5612e-9af6-8f2e-15d8-ff6af29d508a@redhat.com>
In-Reply-To: <89d5612e-9af6-8f2e-15d8-ff6af29d508a@redhat.com>
Subject: RE: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
Date:   Mon, 8 Jul 2019 07:45:24 -0700
Message-ID: <016101d5359b$c71f06c0$555d1440$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQKkmqnjdLO3N2oC5uaUDjK+FnrOigHO1BTBAduA8rSlBK8QgA==
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d6876ba42899ed30ff202aea9961ba7bb350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yea, sorry, I totally missed this, but it does look like it's a Kernel =
nfsd issue.

Frank

> -----Original Message-----
> From: Daniel Gryniewicz [mailto:dang@redhat.com]
> Sent: Monday, July 8, 2019 6:49 AM
> To: Su Yanjun <suyj.fnst@cn.fujitsu.com>; ffilzlnx@mindspring.com
> Cc: linux-nfs@vger.kernel.org
> Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in =
5.2.0-rc7
>=20
> Is this running knfsd or Ganesha as the server?  If it's Ganesha, the =
question
> would be better asked on the Ganesha Devel list =
devel@lists.nfs-ganesha.org
>=20
> If it's knfsd, than Frank isn't the right person to ask.
>=20
> Daniel
>=20
> On 7/7/19 10:20 PM, Su Yanjun wrote:
> > Ang ping?
> >
> > =E5=9C=A8 2019/7/3 9:34, Su Yanjun =E5=86=99=E9=81=93:
> >> Hi Frank
> >>
> >> We tested the pynfs of NFSv4.0 on the latest version of the kernel
> >> (5.2.0-rc7).
> >> I encountered a problem while testing st_lock.testOpenUpgradeLock.
> >> The problem is now as follows:
> >> **************************************************
> >> LOCK24 st_lock.testOpenUpgradeLock : FAILURE
> >>            OP_LOCK should return NFS4_OK, instead got
> >>            NFS4ERR_BAD_SEQID
> >> **************************************************
> >> Is this normal?
> >>
> >> The case is as follows:
> >> Def testOpenUpgradeLock(t, env):
> >>     """Try open, lock, open, downgrade, close
> >>
> >>     FLAGS: all lock
> >>     CODE: LOCK24
> >>     """
> >>     c=3D env.c1
> >>     C.init_connection()
> >>     Os =3D open_sequence(c, t.code, lockowner=3D"lockowner_LOCK24")
> >>     Os.open(OPEN4_SHARE_ACCESS_READ)
> >>     Os.lock(READ_LT)
> >>     Os.open(OPEN4_SHARE_ACCESS_WRITE)
> >>     Os.unlock()
> >>     Os.downgrade(OPEN4_SHARE_ACCESS_WRITE)
> >>     Os.lock(WRITE_LT)
> >>     Os.close()
> >>
> >> After investigation, there was an error in unlock->lock. When
> >> unlocking, the lockowner of the file was not released, causing an
> >> error when locking again.
> >> Will nfs4.0 support 1) open-> 2) lock-> 3) unlock-> 4) lock this
> >> function?
> >>
> >>
> >>
> >
> >

