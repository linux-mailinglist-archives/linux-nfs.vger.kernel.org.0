Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE21C0A55
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 00:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgD3WWc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Apr 2020 18:22:32 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:43390 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgD3WWc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 Apr 2020 18:22:32 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 5F365E061F
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 00:22:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 5F365E061F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1588285349; bh=mGrf1nkN/bqxtNUm+pPXdQ+tXXoIj8alcV2AN5I+wgw=;
        h=Date:From:To:In-Reply-To:References:Subject:From;
        b=rW+Ow/FjcsIieXdn1FLvy2Y6nSFSuxDgORcGDh0XP3IyjYsCScx1zOYT8lBxF2Rb8
         zduobk1b/i1KsRnQtUGUfeYxEuhrmWoFdp8gKVhHJqR7YwGuAcE//Zh1oZwlvsdcsa
         uz20mqEl/L/PafCafSubxzVmbUcaIi1PIMud0v8k=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 5AEBA120262
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 00:22:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 3542EC008A
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 00:22:29 +0200 (CEST)
Date:   Fri, 1 May 2020 00:22:29 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <913945536.2124458.1588285349118.JavaMail.zimbra@desy.de>
In-Reply-To: <563971101.12407489.1586943556660.JavaMail.zimbra@desy.de>
References: <563971101.12407489.1586943556660.JavaMail.zimbra@desy.de>
Subject: Re: multiple EXCHANGE_ID diring a mount.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: multiple EXCHANGE_ID diring a mount.
Thread-Index: noP7bN9i69FFVyqBi2IgCdXjpu5SMEtdKqdk
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I did some investigation and found that indeed there are two places
there nfs4_proc_exchange_id is called: once in nfs41_init_clientid,
and second time in nfs41_discover_server_trunking.

The nfs41_discover_server_trunking at the and calls nfs4_schedule_state_man=
ager,
which itself call nfs4_reclaim_lease:


       mount.nfs-3305  [003] ....  1044.170706: nfs4_exchange_id: error=3D0=
 (OK) dstaddr=3Dlocalhost
     ::1-manager-3308  [003] ....  1044.170748: nfs4_state_mgr: hostname=3D=
localhost clp state=3DMANAGER_RUNNING|CHECK_LEASE|RECLAIM_NOGRACE|0x4000
     ::1-manager-3308  [000] ....  1044.171910: nfs4_exchange_id: error=3D0=
 (OK) dstaddr=3Dlocalhost
     ::1-manager-3308  [000] ....  1044.173263: nfs4_create_session: error=
=3D0 (OK) dstaddr=3Dlocalhost
     ::1-manager-3308  [000] ....  1044.173272: nfs4_state_mgr: hostname=3D=
localhost clp state=3DMANAGER_RUNNING|CHECK_LEASE|SERVER_SCOPE_MISMATCH
     ::1-manager-3308  [000] ....  1044.173275: nfs4_setup_sequence: sessio=
n=3D0x71274229 slot_nr=3D0 seq_nr=3D1 highest_used_slotid=3D0
     ::1-manager-3308  [000] ....  1044.174065: nfs4_sequence_done: error=
=3D0 (OK) session=3D0x71274229 slot_nr=3D0 seq_nr=3D1 highest_slotid=3D15 t=
arget_highest_slotid=3D15 status_flags=3D0 ()
     ::1-manager-3308  [000] ....  1044.174068: nfs4_reclaim_complete: erro=
r=3D0 (OK) dstaddr=3Dlocalhost


Not a big deal, but still can be a result of unintended changes.

Regards,
   Tigran.


----- Original Message -----
> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, April 15, 2020 11:39:16 AM
> Subject: multiple EXCHANGE_ID diring a mount.

> Dear NFS (client) developers,
>=20
> Today I notice, that during mount nfs client sends two  EXCHANGE_ID opera=
tions:
>=20
>=20
>    4 0.000380551 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 NULL Ca=
ll
>    6 0.001052087 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 NULL Re=
ply (Call In 4)
>    8 0.001501687 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call EX=
CHANGE_ID
>    9 0.002105356 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (=
Call In 8)
>    EXCHANGE_ID
>   11 0.002489297 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call EX=
CHANGE_ID
>   <----------------------------------- A second one
>   12 0.003422630 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (=
Call In 11)
>   EXCHANGE_ID
>   14 0.003569542 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call CR=
EATE_SESSION
>   17 0.004701642 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (=
Call In 14)
>   CREATE_SESSION
>   18 0.004822235 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call RE=
CLAIM_COMPLETE
>   19 0.005317324 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (=
Call In 18)
>   RECLAIM_COMPLETE
>   20 0.005489908 131.169.185.213 =E2=86=92 131.169.191.144 NFS V4 Call SE=
CINFO_NO_NAME
>   21 0.006648815 131.169.191.144 =E2=86=92 131.169.185.213 NFS V4 Reply (=
Call In 20)
>   SECINFO_NO_NAME
>=20
>=20
> I observe this with kernel 5.6 and 5.5. On opposite, the older kernels, l=
ike in
> RHEL7 don't do this
>=20
> Older kernel (3.10.0-1062.12.1.el7.x86_64)
>=20
> $ tshark -r ex_id_el7.pcap -Y nfs
>  8 0.006731652 131.169.240.106 -> 131.169.240.145 NFS 336 V4 Call EXCHANG=
E_ID
>  9 0.008812988 131.169.240.145 -> 131.169.240.106 NFS 224 V4 Reply (Call =
In 8)
>  EXCHANGE_ID
> 10 0.009127689 131.169.240.106 -> 131.169.240.145 NFS 292 V4 Call CREATE_=
SESSION
> 13 0.012583411 131.169.240.145 -> 131.169.240.106 NFS 196 V4 Reply (Call =
In 10)
> CREATE_SESSION
> 14 0.012805867 131.169.240.106 -> 131.169.240.145 NFS 208 V4 Call
> RECLAIM_COMPLETE
> 15 0.013716790 131.169.240.145 -> 131.169.240.106 NFS 160 V4 Reply (Call =
In 14)
> RECLAIM_COMPLETE
> 16 0.013981538 131.169.240.106 -> 131.169.240.145 NFS 216 V4 Call
> SECINFO_NO_NAME
> 17 0.019359329 131.169.240.145 -> 131.169.240.106 NFS 176 V4 Reply (Call =
In 16)
> SECINFO_NO_NAME
>=20
>=20
> This is of course not a big problem, but can point to an unintended chang=
e or
> error. The capture
> file available at:
>=20
> https://sas.desy.de/index.php/s/3sRA9WD5BEpZH7z
>=20
> Regards,
>    Tigran.
