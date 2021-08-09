Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3B3E4C4A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhHISo2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 14:44:28 -0400
Received: from mail.rptsys.com ([23.155.224.45]:40483 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhHISo1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 14:44:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id B5AC837B2FD655;
        Mon,  9 Aug 2021 13:44:06 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GGHtMgd6vCBx; Mon,  9 Aug 2021 13:44:02 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id E0FDA37B2FD64C;
        Mon,  9 Aug 2021 13:44:01 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com E0FDA37B2FD64C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628534641; bh=YAdmyxZjK4ecC0fpwW7k0BV+oxSIe9hs7r1O/xfHZ4I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hB9WRCFCXRXY9Wwa3igFzNt9Nup4o5XVU2KFqyAHC7V0C7XjQYiGDGKS7WS5cqRxV
         r8PqnlphQRcTowZMqH5VD57jIF+6/NhXMpZisIPH3LPR0fOqEjvc7ouXiRxGOEw6wN
         2ysGbnXUpTmxlNY57KREtOSXdwi2yODLrUpwSCO8=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c9V9T4-eCDiN; Mon,  9 Aug 2021 13:44:01 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id C0D2D37B2FD648;
        Mon,  9 Aug 2021 13:44:01 -0500 (CDT)
Date:   Mon, 9 Aug 2021 13:44:00 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     hedrick <hedrick@rutgers.edu>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <780407609.1049226.1628534640685.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <19368DD0-74CA-4DB7-9C1F-707106B50635@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com> <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu> <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com> <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu> <77ED566A-7738-4F62-867C-1C2DFC5D34AB@oracle.com> <F5179A41-FB9A-4AB1-BE58-C2859DB7EC06@rutgers.edu> <1065010667.1047836.1628533859535.JavaMail.zimbra@raptorengineeringinc.com> <19368DD0-74CA-4DB7-9C1F-707106B50635@rutgers.edu>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC91 (Linux)/8.5.0_GA_3042)
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: cy+oyT2/5nLl55/z3Zp8j8znl5mzXg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

IIRC most of the NFS server tuning options require a NFS service restart to=
 take effect.

----- Original Message -----
> From: "hedrick" <hedrick@rutgers.edu>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "Chuck Lever" <chuck.lever@oracle.com>, "J. Bruce Fields" <bfields@fi=
eldses.org>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Sent: Monday, August 9, 2021 1:38:33 PM
> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy l=
oad

> Does setting /proc/sys/fs/leases-enable to 0 work while the system is up?=
 I was
> expecting to see lslocks | grep DELE | wc go down. It=E2=80=99s not. It=
=E2=80=99s staying
> around 1850.
>=20
>> On Aug 9, 2021, at 2:30 PM, Timothy Pearson <tpearson@raptorengineering.=
com>
>> wrote:
>>=20
>> FWIW that's *exactly* what we see.  Eventually, if the server is left al=
one for
>> enough time, even the login system stops responding -- it's as if the I/=
O
>> subsystem degrades and eventually blocks entirely.
>>=20
>> ----- Original Message -----
>>> From: "hedrick" <hedrick@rutgers.edu>
>>> To: "Chuck Lever" <chuck.lever@oracle.com>
>>> Cc: "Timothy Pearson" <tpearson@raptorengineering.com>, "J. Bruce Field=
s"
>>> <bfields@fieldses.org>, "linux-nfs"
>>> <linux-nfs@vger.kernel.org>
>>> Sent: Monday, August 9, 2021 1:29:30 PM
>>> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy=
 load
>>=20
>>> Evidence is ambiguous. It seems that NFS activity hangs. The first time=
 this
>>> occurred I saw a process at 100% running rpciod. I tried to do a =E2=80=
=9Csync=E2=80=9D and
>>> reboot, but the sync hung.
>>>=20
>>> The last time I couldn=E2=80=99t get data, but the kernel was running a=
nd responding to
>>> ping. An ssh session responded to CR but when I tried to sudo it hung. =
Attempt
>>> to login hung. Oddly, even though the ssh session responded to CR, sysl=
og
>>> entries on the local system stopped until the reboot. However we also s=
end
>>> syslog entries to a central server. Those continued and showed a contin=
uing set
>>> of mounts and unmounts happening through the reboot.
>>>=20
>>> I was goiog to get a stack trace of the 100% process if that happened a=
gain, but
>>> last time I wasn=E2=80=99t in a situation to do that. I don=E2=80=99t t=
hink users will put up
>>> with further attempts to debug, so for the moment I=E2=80=99m going to =
try disabling
>>> delegations.
>>>=20
>>>> On Aug 9, 2021, at 1:37 PM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>>>=20
>>>> Then when you say "server hangs" you mean that the entire NFS server
> >>> system deadlocks. It's not just unresponsive on one or more exports.
