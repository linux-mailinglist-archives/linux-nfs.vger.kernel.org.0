Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F2A3E4EB7
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhHIVt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 17:49:57 -0400
Received: from mail.rptsys.com ([23.155.224.45]:45960 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232193AbhHIVt5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 17:49:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id BD14837B2FF976;
        Mon,  9 Aug 2021 16:49:35 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id b9In9Odf9Yr6; Mon,  9 Aug 2021 16:49:31 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id DB40137B2FF972;
        Mon,  9 Aug 2021 16:49:30 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com DB40137B2FF972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628545770; bh=i5aRO32YO4o5RGtcBm/1Bw51HaX6BIP4KZJF+O7DpEY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Ja9AmoAX4zAwPm2bwzjV2bi4DA0WKpsRmxUJumsjilJ4FbJJQZMnsu6cjmumDgMAz
         9KmJVa2v5Eo7DEWrebKpa0lajcfPU0VhznK1Vud/n6jGw7e/i19LvHjr00N9JxVTlF
         0Xs5er0QCYpAiUt4+ZXfKGRgjY7lTD8Bb09CGnsA=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qdiWC7yvrXWe; Mon,  9 Aug 2021 16:49:30 -0500 (CDT)
Received: from vali.starlink.edu (vali.starlink.edu [192.168.3.21])
        by mail.rptsys.com (Postfix) with ESMTP id BE93937B2FF96F;
        Mon,  9 Aug 2021 16:49:30 -0500 (CDT)
Date:   Mon, 9 Aug 2021 16:49:30 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     hedrick <hedrick@rutgers.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <921953712.1074013.1628545770061.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <FE5ABF17-F030-4A58-9150-49BAB4E8D208@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com> <F5179A41-FB9A-4AB1-BE58-C2859DB7EC06@rutgers.edu> <1065010667.1047836.1628533859535.JavaMail.zimbra@raptorengineeringinc.com> <19368DD0-74CA-4DB7-9C1F-707106B50635@rutgers.edu> <20210809184911.GD8394@fieldses.org> <15AD846A-4638-4ACF-B47C-8EF655AD6E85@rutgers.edu> <81413392.1050622.1628535375526.JavaMail.zimbra@raptorengineeringinc.com> <FE5ABF17-F030-4A58-9150-49BAB4E8D208@rutgers.edu>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC83 (Linux)/8.5.0_GA_3042)
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRnsuG+zO3JoCWACAAAPHgIAACdwAgAACeYCAAAYTAIAADpYAgAAAaoCAAAIdgIAAAvmAgAAAhwASVj4mvf9tcHuA7mVOwCA=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm not sure that is much different than the load patterns we end up genera=
ting, with mixed remote and local I/O.  I'd think that such a scenario is f=
airly typical, especially when factoring in backup processes.

----- Original Message -----
> From: "hedrick" <hedrick@rutgers.edu>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Chuck Lever" <chuck.lever@=
oracle.com>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Sent: Monday, August 9, 2021 3:54:17 PM
> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy l=
oad

> I just realized there=E2=80=99s one thing you should know. We run Cisco=
=E2=80=99s AMP for
> Endpoints on the server. The goal is to detect malware that our users mig=
ht put
> on the file system. Typically one is worried about malware installed n cl=
ient,
> but we=E2=80=99re concerned that developers may be using java and python =
libraries with
> known issues, and those will commonly be stored on the server.
>=20
> If AMP is doing its job, it will check most new files. I=E2=80=99m not su=
re whether that
> creates atypical usage or not.
>=20
>> On Aug 9, 2021, at 2:56:15 PM, Timothy Pearson <tpearson@raptorengineeri=
ng.com>
>> wrote:
>>=20
>> Can confirm -- same general backtrace I sent in earlier.
>>=20
>> That means the bug is:
>> 1.) Not architecture specific
>> 2.) Not filesystem specific
>>=20
>> I was originally concerned it was related to BTRFS or POWER-specific, go=
od to
>> see it is not.
>>=20
>> ----- Original Message -----
>>> From: "hedrick" <hedrick@rutgers.edu>
>>> To: "J. Bruce Fields" <bfields@fieldses.org>
>>> Cc: "Timothy Pearson" <tpearson@raptorengineering.com>, "Chuck Lever"
>>> <chuck.lever@oracle.com>, "linux-nfs"
>>> <linux-nfs@vger.kernel.org>
>>> Sent: Monday, August 9, 2021 1:51:05 PM
>>> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy=
 load
>>=20
>>> I have. I was trying to avoid a reboot.
>>>=20
>>> By the way, after the first failure, during reboot, syslog showed the f=
ollowing.
>>> I=E2=80=99m unclear what it means, bu tit looks ike it might be from th=
e failure
>>>=20
>>>=20
>>>=20
>>>> On Aug 9, 2021, at 2:49 PM, J. Bruce Fields <bfields@fieldses.org> wro=
te:
>>>>=20
>>>> On Mon, Aug 09, 2021 at 02:38:33PM -0400, hedrick@rutgers.edu wrote:
>>>>> Does setting /proc/sys/fs/leases-enable to 0 work while the system is
>>>>> up? I was expecting to see lslocks | grep DELE | wc go down. It=E2=80=
=99s not.
>>>>> It=E2=80=99s staying around 1850.
>>>>=20
>>>> All it should do is prevent giving out *new* delegations.
>>>>=20
>>>> Best is to set that sysctl on system startup before nfsd starts.
>>>>=20
>>>>>> On Aug 9, 2021, at 2:30 PM, Timothy Pearson
>>>>>> <tpearson@raptorengineering.com> wrote:
>>>>>>=20
>>>>>> FWIW that's *exactly* what we see.  Eventually, if the server is
>>>>>> left alone for enough time, even the login system stops responding
>>>>>> -- it's as if the I/O subsystem degrades and eventually blocks
>>>>>> entirely.
>>>>=20
>>>> That's pretty common behavior across a variety of kernel bugs.  So on
>>>> its own it doesn't mean the root cause is the same.
>>>>=20
> >>> --b.
