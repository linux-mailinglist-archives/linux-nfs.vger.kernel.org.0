Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4F3E7D6C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhHJQXY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 12:23:24 -0400
Received: from mail.rptsys.com ([23.155.224.45]:39271 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234949AbhHJQXY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Aug 2021 12:23:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 709B737B30D4E7;
        Tue, 10 Aug 2021 11:23:01 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dhSFAs0p1iEe; Tue, 10 Aug 2021 11:22:56 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id A442B37B30D4E4;
        Tue, 10 Aug 2021 11:22:56 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com A442B37B30D4E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628612576; bh=1mlFuoFsw4RVtsBspL78rnmYqmFxxbbWSK6mQsW9lrg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FGL6eQxnKU4LUHEY/RRF5LW5mHiDrhFBfPhf901gAoY17Z9KSOCJBAp/OhLhNOwQm
         9du/AHlZr4QG10CXNpcpu0NpnN54Q0vAcEUoTm9XqCiGj/wMiQzrSAyUSv+jQk0uxJ
         T7swuIP+JnMOrp07Jl9vXP7ZTKpLC7l+R4X71Fi4=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id imbXdxvFPCWj; Tue, 10 Aug 2021 11:22:56 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 7E58837B30D4E1;
        Tue, 10 Aug 2021 11:22:56 -0500 (CDT)
Date:   Tue, 10 Aug 2021 11:22:55 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     hedrick <hedrick@rutgers.edu>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <507179738.1235330.1628612575436.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1119B476-171F-4C5A-9DEF-184F211A6A98@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com> <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com> <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu> <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu> <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com> <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu> <77ED566A-7738-4F62-867C-1C2DFC5D34AB@oracle.com> <1119B476-171F-4C5A-9DEF-184F211A6A98@rutgers.edu>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC91 (Linux)/8.5.0_GA_3042)
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: PcTFBMO3iJDt86usnZsDw74BBJYrIQ==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To chime in on the client topic, we have a pretty wide mix of kernels in us=
e and haven't really seen any issues aside from some oddities specific to 4=
.14 / 5.3 on armhf (embedded dev systems).  I know 5.13.4 is fine on the cl=
ient side.

----- Original Message -----
> From: "hedrick" <hedrick@rutgers.edu>
> To: "Chuck Lever" <chuck.lever@oracle.com>
> Cc: "Timothy Pearson" <tpearson@raptorengineering.com>, "J. Bruce Fields"=
 <bfields@fieldses.org>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Sent: Tuesday, August 10, 2021 10:03:48 AM
> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy l=
oad

> FYI, we=E2=80=99re reasonably sure 5.8 is OK on the client side. We don=
=E2=80=99t have much
> testing with 5.4, but we=E2=80=99re hoping current patch levels of 5.4 ar=
e as well. So
> we=E2=80=99re not really reporting anything here about the client side. (=
I=E2=80=99ve looked at
> both upstream and Ubuntu kernel source. They=E2=80=99re pretty good about=
 following the
> upstream NFS source.)
>=20
>> On Aug 9, 2021, at 1:37 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>>=20
>>> We=E2=80=99ve also had a history of issues with 4.2 problems on clients=
. That=E2=80=99s why we
>>> backed off to 4.0 initially. Clients were seeing hangs.
>>=20
> > Let's stick with the server issue for the moment.
