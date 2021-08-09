Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD443E4C28
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 20:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhHISb2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 14:31:28 -0400
Received: from mail.rptsys.com ([23.155.224.45]:13201 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235334AbhHISb0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 14:31:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 8E11F37B2FD40E;
        Mon,  9 Aug 2021 13:31:04 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MkWdjweFs0WV; Mon,  9 Aug 2021 13:30:59 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id AFEB337B2FD404;
        Mon,  9 Aug 2021 13:30:59 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com AFEB337B2FD404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628533859; bh=GE75/w75Z+n12N/Oo9YBZrUlPJ/VLiT2pAw72DqaJJ0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LFois8AdZkk1lYqh2DkazL/qwQzNiUtnNxe29Djh6UIdV+OlFvMkIZM7bcwTx4ls0
         YmN4s0P9nQNk8VS+ortr/En3OGtu7Gj3qRkv5rQBElpmWwekU/VxibJY4b3oWti5oA
         rznZSFNIyO2tqHjGcH+UKNvQAV5jlnOTY4aM5mRM=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fk1BRtmVwjna; Mon,  9 Aug 2021 13:30:59 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 8F51037B2FD401;
        Mon,  9 Aug 2021 13:30:59 -0500 (CDT)
Date:   Mon, 9 Aug 2021 13:30:59 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     hedrick <hedrick@rutgers.edu>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1065010667.1047836.1628533859535.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <F5179A41-FB9A-4AB1-BE58-C2859DB7EC06@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com> <1288667080.5652.1625478421955.JavaMail.zimbra@raptorengineeringinc.com> <B4D8C4B7-EE8C-456C-A6C5-D25FF1F3608E@rutgers.edu> <3A4DF3BB-955C-4301-BBED-4D5F02959F71@rutgers.edu> <359473237.1035413.1628528802863.JavaMail.zimbra@raptorengineeringinc.com> <2FEAFB26-C723-450D-A115-1D82841BBF73@rutgers.edu> <77ED566A-7738-4F62-867C-1C2DFC5D34AB@oracle.com> <F5179A41-FB9A-4AB1-BE58-C2859DB7EC06@rutgers.edu>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC91 (Linux)/8.5.0_GA_3042)
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: /4LRKH3x2rGXKyuTO2X5jsbUAugA9w==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

FWIW that's *exactly* what we see.  Eventually, if the server is left alone=
 for enough time, even the login system stops responding -- it's as if the =
I/O subsystem degrades and eventually blocks entirely.

----- Original Message -----
> From: "hedrick" <hedrick@rutgers.edu>
> To: "Chuck Lever" <chuck.lever@oracle.com>
> Cc: "Timothy Pearson" <tpearson@raptorengineering.com>, "J. Bruce Fields"=
 <bfields@fieldses.org>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Sent: Monday, August 9, 2021 1:29:30 PM
> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy l=
oad

> Evidence is ambiguous. It seems that NFS activity hangs. The first time t=
his
> occurred I saw a process at 100% running rpciod. I tried to do a =E2=80=
=9Csync=E2=80=9D and
> reboot, but the sync hung.
>=20
> The last time I couldn=E2=80=99t get data, but the kernel was running and=
 responding to
> ping. An ssh session responded to CR but when I tried to sudo it hung. At=
tempt
> to login hung. Oddly, even though the ssh session responded to CR, syslog
> entries on the local system stopped until the reboot. However we also sen=
d
> syslog entries to a central server. Those continued and showed a continui=
ng set
> of mounts and unmounts happening through the reboot.
>=20
> I was goiog to get a stack trace of the 100% process if that happened aga=
in, but
> last time I wasn=E2=80=99t in a situation to do that. I don=E2=80=99t thi=
nk users will put up
> with further attempts to debug, so for the moment I=E2=80=99m going to tr=
y disabling
> delegations.
>=20
>> On Aug 9, 2021, at 1:37 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>>=20
>> Then when you say "server hangs" you mean that the entire NFS server
> > system deadlocks. It's not just unresponsive on one or more exports.
