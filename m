Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE85A3E4C78
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhHIS4m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 14:56:42 -0400
Received: from mail.rptsys.com ([23.155.224.45]:52191 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235246AbhHIS4l (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 14:56:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 852C837B2FD846;
        Mon,  9 Aug 2021 13:56:20 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zvZ4LSYTRC8h; Mon,  9 Aug 2021 13:56:15 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id B6BD537B2FD843;
        Mon,  9 Aug 2021 13:56:15 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com B6BD537B2FD843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628535375; bh=FMLZ8hNyvbnGzYgGBKPoxOk46EZ33HKtEXOQMwuWjaU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZDya7bGLbFwmsgB5QkL46+/+/FaYXtEGasCzY5d6dtrwHrU6tfj3MtfTGRMPRHESl
         Qfu7wpZL97YpvzekqmLOuepufE24LpNH0pIXsJp7uq+hDMg/oZBGRfJDDrg32UvhVP
         B5Z2WBUoGVLH/x8Q4+eatKB+Kf965NrFDXMKe3oA=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pOUKttphQ-kK; Mon,  9 Aug 2021 13:56:15 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 91B5237B2FD840;
        Mon,  9 Aug 2021 13:56:15 -0500 (CDT)
Date:   Mon, 9 Aug 2021 13:56:15 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     hedrick <hedrick@rutgers.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <81413392.1050622.1628535375526.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <15AD846A-4638-4ACF-B47C-8EF655AD6E85@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com> <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu> <77ED566A-7738-4F62-867C-1C2DFC5D34AB@oracle.com> <F5179A41-FB9A-4AB1-BE58-C2859DB7EC06@rutgers.edu> <1065010667.1047836.1628533859535.JavaMail.zimbra@raptorengineeringinc.com> <19368DD0-74CA-4DB7-9C1F-707106B50635@rutgers.edu> <20210809184911.GD8394@fieldses.org> <15AD846A-4638-4ACF-B47C-8EF655AD6E85@rutgers.edu>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: multipart/alternative; 
        boundary="=_cfa040c1-3e03-4316-ae9f-32dd2b5d6505"
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC91 (Linux)/8.5.0_GA_3042)
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRnsuG+zO3JoCWACAAAPHgIAACdwAgAACeYCAAAYTAIAADpYAgAAAaoCAAAIdgIAAAvmAgAAAhwASVj4mvQ==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=_cfa040c1-3e03-4316-ae9f-32dd2b5d6505
Content-Type: multipart/related; 
	boundary="=_14bc784f-9332-4370-9580-620f33f84a9c"

--=_14bc784f-9332-4370-9580-620f33f84a9c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Can confirm -- same general backtrace I sent in earlier.

That means the bug is:
1.) Not architecture specific
2.) Not filesystem specific

I was originally concerned it was related to BTRFS or POWER-specific, good =
to see it is not.

----- Original Message -----
> From: "hedrick" <hedrick@rutgers.edu>
> To: "J. Bruce Fields" <bfields@fieldses.org>
> Cc: "Timothy Pearson" <tpearson@raptorengineering.com>, "Chuck Lever" <ch=
uck.lever@oracle.com>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Sent: Monday, August 9, 2021 1:51:05 PM
> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy l=
oad

> I have. I was trying to avoid a reboot.
>=20
> By the way, after the first failure, during reboot, syslog showed the fol=
lowing.
> I=E2=80=99m unclear what it means, bu tit looks ike it might be from the =
failure
>=20
>=20
>=20
>> On Aug 9, 2021, at 2:49 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>>
>> On Mon, Aug 09, 2021 at 02:38:33PM -0400, hedrick@rutgers.edu wrote:
>>> Does setting /proc/sys/fs/leases-enable to 0 work while the system is
>>> up? I was expecting to see lslocks | grep DELE | wc go down. It=E2=80=
=99s not.
>>> It=E2=80=99s staying around 1850.
>>
>> All it should do is prevent giving out *new* delegations.
>>
>> Best is to set that sysctl on system startup before nfsd starts.
>>
>>>> On Aug 9, 2021, at 2:30 PM, Timothy Pearson
>>>> <tpearson@raptorengineering.com> wrote:
>>>>
>>>> FWIW that's *exactly* what we see.  Eventually, if the server is
>>>> left alone for enough time, even the login system stops responding
>>>> -- it's as if the I/O subsystem degrades and eventually blocks
>>>> entirely.
>>
>> That's pretty common behavior across a variety of kernel bugs.  So on
>> its own it doesn't mean the root cause is the same.
>>
> > --b.

--=_14bc784f-9332-4370-9580-620f33f84a9c--

--=_cfa040c1-3e03-4316-ae9f-32dd2b5d6505--
