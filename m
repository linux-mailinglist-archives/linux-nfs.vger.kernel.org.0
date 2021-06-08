Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0715A39F21C
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFHJSC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 05:18:02 -0400
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:44640
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229507AbhFHJSB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Jun 2021 05:18:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUEqSwTirFBhoYl6Savum7hiHCmDWAaeQry6cpbCNWAi/YrRP6mmFCt5RaBsmFm2bUEvMVzgqmVbZdGw+DH9Xttl97YfCwJuabpaj0VVSHlBqPhmDt9rf0tBuiNNs1N0jnLtbTTDRASQ4s33aoa2wdFtEB2SuBzdSzFWNhO1AYgfynhYz5tJh4msq2BXHi51HqhYPVX8hhPJPkEuMWbMiBW2LiNJbiMo4YsHvQK0rS3zGcXW04djcVIEB3QmVY6jDAZLH2XRGPv/wG+kaLBc8bH8G0iZ14MR0InWQi3qY1pHa7B6zuOL2bQG2x5EfB7sKAZfU/0qmBZNhqhEUUZLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5cZdnX/JS0N6JuKz+tGWUzD4TeWb5ItZoDOvYaNKQY=;
 b=YRuKQRB+dLyeUKp5vYC5vWwziYaqkQqvGL6k8q3Z+Bd4PEZ4GrYyQF7W5ay4wOYymVog/IWg1V1jHPv9x1nWffuhOAsSBVpZa1Lsw8uEKg82jkWb0GafopsLgxD8MuqYop46XUFg8EOoGeWWX2PXRRZ0NJbupuigHrLckEUy/4jm/lq5eNLhi8tZ7wjPuDXOdXcjo62TWlnDYINekPuJKrxwekfAvj5GPrz8SCE4S3uFIY2nAzrT8qtQOSt3WMaONe1BNsroSBbqP9v8uT80LWe2DG4VZWFpKgyOVxWyL3+/wxpeVHP1LlCrbXZlY5cU918x3z7B+8R2L/4YVu4UzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5cZdnX/JS0N6JuKz+tGWUzD4TeWb5ItZoDOvYaNKQY=;
 b=1Cw6HLtXtDlr/ejvW10tBk64sAuFwgOkytsXpp7tHEXBGmamiCLEhH8XVW9y/HRE936C4Afp2QnsodIUvGdHJVUX5yW2HuPIXUxO+vOv8dRoTnBTXyZ0x40poM/9FNVoeuDO7kBvs1bx9fMN0k3/gySoJFnln3Bu+YUZyQuBiwM=
Received: from CO1PR05MB8101.namprd05.prod.outlook.com (2603:10b6:303:fa::14)
 by MWHPR05MB2974.namprd05.prod.outlook.com (2603:10b6:300:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.17; Tue, 8 Jun
 2021 09:16:07 +0000
Received: from CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002]) by CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 09:16:07 +0000
From:   Michael Wakabayashi <mwakabayashi@vmware.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@RedHat.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgAGJKICAAZPoloAADT6AgAAH7wqAABF6AIAAETsAgAAJXACAG0yW/w==
Date:   Tue, 8 Jun 2021 09:16:07 +0000
Message-ID: <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
 <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
 <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>,<CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
In-Reply-To: <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [67.161.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 128f3686-242b-4574-96b4-08d92a5e0c66
x-ms-traffictypediagnostic: MWHPR05MB2974:
x-microsoft-antispam-prvs: <MWHPR05MB29747E3234B02C1B329C3814B7379@MWHPR05MB2974.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jRamFgdQ+slu7dmLJC084fb5jtDEzGoXpdR/e+YjqRu3FMhMm+7A93p05kr/gTqk2nHMfYaWDXPchJy+LZUpRCrS5GERl2VtnZLzc2/30Wtkk1cmzWYtfVabZlwzuN4hvv07rotOyoGEg7BQl79aFdzlDpdcCJRT0kpks8ZhZ0mFT71wzGisfpG8TsGwsH19A3Zb7NWr7Tm1dUn2XWEfXmY8aIKq3NfCojEm5/4HKBacShYAKXlHPVvo3GZcUuhv2uAVk9Z6KBaLXbyOOgrPlJg7PrYP4Cnq/nqpVer2KiPNuRDlPkTDWhqaEmcry3YJfdJJKgbw+5lY9IkwhA0KFOVM/iVmQ3G1B7jNpMWLGytJ4UBir0Riws9p+zYloqoyVNXWSUkGDkBzwxALjEVGGyA9blhCjlay3b9g3Yv757WAXgS/2tqN54PxM5XLf3pPGPhOc+IKqVKgJMJrTiUJ128ADURRH2fpayAPCMkaoU9Ku8I1I08bR8SPNLgA7bl+dptRPOFGHLkDwyUvYyzRGkBm2yQgLLQvWHNDwQFdoEVkZPl2TVHqLCiUNqkms9FsIy3B+OUxPJCMlzHUm77grFtJNE3qOYQTpo8WQifzkEA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8101.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(4326008)(5660300002)(52536014)(33656002)(7696005)(316002)(110136005)(71200400001)(54906003)(86362001)(99936003)(8936002)(6506007)(55016002)(66446008)(64756008)(66556008)(66476007)(66946007)(66576008)(76116006)(9686003)(8676002)(478600001)(38100700002)(122000001)(2906002)(186003)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b+Ljv5/fHSV2ZaRjuA5BklooZe3chejHYDfjHnJoraiqWm4i0bjHX+TT5I?=
 =?iso-8859-1?Q?u9j7MdSnnRap+FzT+ud2Cd597cdQaAjiBVtw4ZThqhjAsxcqTzhNx9KZeX?=
 =?iso-8859-1?Q?4O9ZRe8XvuaGkf72mPbGTrEslyWt15S6akiduzSxkAn6VTpfe1jpXJZPc/?=
 =?iso-8859-1?Q?7zMjSCJairiiQzgixYKp9HTQtQAVwE6cxG0jJq4EM2mCCFFptLCN7Yabd4?=
 =?iso-8859-1?Q?6lyLD5522SOUYptAxIjawYar4U5bDhF2AGcEB2MnaZKem0xmjjPpy2MmfX?=
 =?iso-8859-1?Q?HgW2VgYuiUWE7s/p2JnBidpGOqZWx68ok1SdMLNVDi2+BzfXolZICYoIbx?=
 =?iso-8859-1?Q?1XBO8F0wPsiZH3/PKLwfBeSw94yCqLQgvoYA3AaYqQuJOUEHlycYypTkav?=
 =?iso-8859-1?Q?lPf+2txP0tVA51x5G92wUDOWX5g6VepW5tBzDSx8CBIG/cFM/TJV4t/FYn?=
 =?iso-8859-1?Q?x88GVwJsIA4T7d/5fIMqZT1+IrwGk/IdI0QoWm8Tl4xXDyb8P4HowxASuq?=
 =?iso-8859-1?Q?dHdaJSewnZyiOqTMqpIrHsAk1FKbkmcOflkAot0cnDNmN2PJAmkptzMe+8?=
 =?iso-8859-1?Q?UwR8LQuUGIalxcjILuG19ciCXMHhPtGBL/gMEZPtYTHvB+kgPi+FyXP2kj?=
 =?iso-8859-1?Q?fBhsTuqIV0ht2FFECkvus+7UZZt3vyhwfq09eQoBzQw7ht6vVaMliayvcl?=
 =?iso-8859-1?Q?mGxEtvMHUKJDaXbDfpKv0GO33nzTr//y1qE+1/a+Skb+I1PAb1ey+jy+ai?=
 =?iso-8859-1?Q?VbGSo0ME+UfxU7z49Z8hfAT4h9T5PaO2UDJ6R6Vu65JmbHcBkUpnKQoNcm?=
 =?iso-8859-1?Q?6NAUIQkpT9RS3flbpozYYUOkczhZQiIh6EPb+qk4yi7BMXS8u7muIM2XtN?=
 =?iso-8859-1?Q?lsMX9XQIEhtupWPDUwEKDeFoTOFIHjk3M6ByC0HjonGCZqViWKb1oHzapw?=
 =?iso-8859-1?Q?LSoJk+WdxlvEoUPbHoCvKxaOumqdX6DLPvr7QTtTVEbdXoESqjP+zB3S90?=
 =?iso-8859-1?Q?YeQ/DFdru2DbUZ16+QQhqUyTL8snSkq2bXw6nvmNM9gPjbf/Qd7taZrUle?=
 =?iso-8859-1?Q?7VtA+DX6xGkP2gbc+UFbsU4adCGjyZqolL35bqvcwrpXwJJSSPg5cMlyc5?=
 =?iso-8859-1?Q?LZOV2iPx2q6yYCNEtBn/ExQI0rB55sb+xoE+VluZJ7R11tSt2PlkSKlZ/f?=
 =?iso-8859-1?Q?IlAkhb7K1SxCWEVCek9r7Le40Q6tND1uG9YnIxqT9OIv3F+euRJB/Uix4X?=
 =?iso-8859-1?Q?eK+CF1UL7nil0V0nevPnuoIGdTAhFv095I7tpk3AhvIjkYSMpUz33owWIT?=
 =?iso-8859-1?Q?SoGoN9apu2nhEEsVjAkB34CjKkx5FOtJ1w9KXobaiJzIu34=3D?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_005_CO1PR05MB810120D887411CCDA786A849B7379CO1PR05MB8101namp_"
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128f3686-242b-4574-96b4-08d92a5e0c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 09:16:07.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXMG1O0ZB9QTHQ1+Xf91Oj+BsZd3PttO+vihm4eqoOX8IHau6bI9vQ+60tkfn3tc6BXDkyNWzZYXbzzZAQA2bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB2974
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--_005_CO1PR05MB810120D887411CCDA786A849B7379CO1PR05MB8101namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Olga,=0A=
=0A=
> > You say that it's taken offline. If it's offline there shouldn't be=0A=
> > anything listening on port 2049. I was only able to reproduce the=0A=
> > problem when a client is able to send a SYN to the server and not=0A=
> > getting a reply back. If the server is offline, there will always be a=
=0A=
> > reply back (RST or something of the sorts). Client tries a bit but it=
=0A=
> > never gets stuck in the rpc_execute() state because it would get a=0A=
> > reply from the TCP layer. Your stack is where =A0there is no TCP reply=
=0A=
> > from the server.=0A=
=0A=
> I'm actually claiming their infrastructure is broken. He says the=0A=
> server is down. If that's the case, the TCP layer will time out fast=0A=
> and it will not visibly block other mounts. However, if the server is=0A=
> unresponsive, that's what the provided stack shows, then the TCP=0A=
> timeout is much larger. I'm saying the server should truly be=0A=
> unreachable and not unresponsive.=0A=
=0A=
I don't think the infrastructure is broken.=0A=
The behavior we're seeing seems to be correct (explained below).=0A=
=0A=
> If the server is offline, there will always be a reply back=0A=
> (RST or something of the sorts).=0A=
=0A=
> He says the server is down. If that's the case, the TCP layer will=0A=
> time out fast=0A=
=0A=
I believe these two statements are incorrect. Let me explain.=0A=
=0A=
If the server is offline (for example physically unplugged from power)=0A=
then this unplugged server cannot reply. It's a brick.=0A=
CPU, memory, disk and NIC all have zero power. =A0There's no operating=0A=
system running, the dead server won't see the TCP request packet=0A=
and cannot reply so the following cannot be true:=0A=
> If the server is offline, there will always be a reply back=0A=
=0A=
=0A=
Here's what's happening at the TCP layer:=0A=
I took a TCP packet capture (see attached nfsv4.pcap file) and can see the=
=0A=
NFS client(10.162.132.231) attempting a 3-way TCP handshake with the=0A=
powered-off/offline server(2.2.2.2).  The client sends a TCP SYN to=0A=
the NFS server. =A0But the NFS server is powered off, so the NFS client=0A=
times out waiting for the TCP SYN-ACK reply.  On timeout, the NFS client=0A=
will retransmit the TCP SYN packet, and eventually time out again=0A=
waiting for the SYN-ACK reply.  This process repeats itself until TCP=0A=
retransmits are exhausted.  Eventually the NFS client mount command=0A=
gives up (after 3 minutes) and exits.=0A=
=0A=
During this 3 minute period every other NFS mount command on the host where=
=0A=
the NFS client is running is blocked; this effectively caused a=0A=
denial of service attack since no other user was able to NFS mount anything=
,=0A=
including perfectly valid NFS mounts.=0A=
To make matters worse, after the mount command exited, the workload would=
=0A=
retry the powered off mount command again extending the duration of the=0A=
inadvertent denial of service.=0A=
=0A=
> He says the server is down. If that's the case, the TCP layer will=0A=
> time out fast=0A=
=0A=
As described above, the 3-way TCP handshake timeout is relatively slow and=
=0A=
the mount command takes 3 minutes to exit.=0A=
=0A=
I believe you're thinking of the case when the NFS server is powered-on,=0A=
but has no Linux process listening on NFS port 2049. In this case=0A=
the NFS server --will-- reply  quickly (within milliseconds) with a=0A=
TCP RST/Reset packet and the NFS client will quickly exit the mount process=
=0A=
with an error code.=0A=
=0A=
> There are valid protocol reasons why the NFSv4 client has to check=0A=
> whether or not the new mount is really talking to the same server but=0A=
> over a different IP addresses.=0A=
=0A=
Hi Trond,=0A=
=0A=
I ran the following script:=0A=
=A0 =A0 #!/bin/sh -x=0A=
=A0 =A0 mount -o vers=3D4 -v -v -v 2.2.2.2:/fake_path /tmp/mnt.dead &=0A=
    echo PID_OF_DEAD_BG_MOUNT=3D$!=0A=
=A0 =A0 sleep 5 # give time for the first mount to execute in the backgroun=
d=0A=
=A0 =A0 mount -o vers=3D4 -v -v -v 10.188.76.67:/git /tmp/mnt.alive=0A=
on Ubuntu 21.04, MacOS 11.1 and FreeBSD 11.4.=0A=
=0A=
The undesirable blocking behavior only appeared on Ubuntu.=0A=
MacOs and FreeBSD executed the script fine meaning the 10.188.76.67:/git=0A=
NFS share immediately and successfully mounted without blocking.=0A=
=0A=
On Ubuntu, a user runs "mount <unreachable-ip-address>:<fake-path>"=0A=
which blocks mounts for every other user on the system, this is undesirable=
.=0A=
Our virtual machines basically crashed because we had several hundred=0A=
to several thousand blocked mount processes preventing workloads from=0A=
making progress.=0A=
=0A=
We'd prefer the mount behavior of the MacOS or FreeBSD implementations,=0A=
even if it's less secure, since at least it's not taking down=0A=
our servers with an unintentional DoS attack.=0A=
=0A=
Is there any chance of looking at the FreeBSD mount implementation and seei=
ng=0A=
if it is correct, and if so, have the Linux mount command emulate this beha=
vior?=0A=
=0A=
Thanks, Mike=0A=
=0A=
p.s.=0A=
I've attached the following 4 files which were generated on Ubuntu 21.04:=
=0A=
  1. mount_hang.sh: script running mount test=0A=
  2. mount_hang.sh.log: output of mount_hang.sh=0A=
  3. trace_pipe.txt: output of: cat /sys/kernel/debug/tracing/trace_pipe > =
trace_pipe.txt=0A=
                        with events/sunrpc/enable set to 1=0A=
                             events/nfs4/enable   set to 1=0A=
  4. nfsv4.pcap: output of "tcpdump -v -v -v -v  -s 0 -w /tmp/nfsv4.pcap po=
rt 2049"=0A=
=0A=
The test procedure was:=0A=
- run mount_hang.sh on the Ubunut 21.04 VM=0A=
- after seeing the second mount command execute=0A=
- wait about 5 seconds=0A=
- press control-C to exit the mount_hang.sh script.=

--_005_CO1PR05MB810120D887411CCDA786A849B7379CO1PR05MB8101namp_
Content-Type: text/x-sh; name="mount_hang.sh"
Content-Description: mount_hang.sh
Content-Disposition: attachment; filename="mount_hang.sh"; size=170;
	creation-date="Tue, 08 Jun 2021 08:52:52 GMT";
	modification-date="Tue, 08 Jun 2021 08:52:52 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL3NoIC14Cgptb3VudCAtbyB2ZXJzPTQgLXYgLXYgLXYgMi4yLjIuMjovZmFrZV9wYXRo
IC90bXAvbW50LmRlYWQgJgplY2hvIFBJRF9PRl9ERUFEX0JHX01PVU5UPSQhCnNsZWVwIDUKCm1v
dW50IC1vIHZlcnM9NCAtdiAtdiAtdiAxMC4xODguNzYuNjc6L2dpdCAvdG1wL21udC5hbGl2ZQo=

--_005_CO1PR05MB810120D887411CCDA786A849B7379CO1PR05MB8101namp_
Content-Type: application/octet-stream; name="mount_hang.sh.log"
Content-Description: mount_hang.sh.log
Content-Disposition: attachment; filename="mount_hang.sh.log"; size=634;
	creation-date="Tue, 08 Jun 2021 08:52:52 GMT";
	modification-date="Tue, 08 Jun 2021 08:52:52 GMT"
Content-Transfer-Encoding: base64

cm9vdEBtaWtlcy11YnVudHUtMjEtMDQ6L3RtcC9kYmcjIGRhdGU7IC4vbW91bnRfaGFuZy5zaApU
dWUgSnVuICA4IDA3OjA5OjQ1IEFNIFVUQyAyMDIxCisgZWNobyBQSURfT0ZfREVBRF9CR19NT1VO
VD03MTQ4ODIKUElEX09GX0RFQURfQkdfTU9VTlQ9NzE0ODgyCisgc2xlZXAgNQorIG1vdW50IC1v
IHZlcnM9NCAtdiAtdiAtdiAyLjIuMi4yOi9mYWtlX3BhdGggL3RtcC9tbnQuZGVhZAptb3VudC5u
ZnM6IHRpbWVvdXQgc2V0IGZvciBUdWUgSnVuICA4IDA3OjExOjQ1IDIwMjEKbW91bnQubmZzOiB0
cnlpbmcgdGV4dC1iYXNlZCBvcHRpb25zICd2ZXJzPTQsYWRkcj0yLjIuMi4yLGNsaWVudGFkZHI9
MTAuMTYyLjEzMi4yMzEnCisgbW91bnQgLW8gdmVycz00IC12IC12IC12IDEwLjE4OC43Ni42Nzov
Z2l0IC90bXAvbW50LmFsaXZlCm1vdW50Lm5mczogdGltZW91dCBzZXQgZm9yIFR1ZSBKdW4gIDgg
MDc6MTE6NTAgMjAyMQptb3VudC5uZnM6IHRyeWluZyB0ZXh0LWJhc2VkIG9wdGlvbnMgJ3ZlcnM9
NCxhZGRyPTEwLjE4OC43Ni42NyxjbGllbnRhZGRyPTEwLjE2Mi4xMzIuMjMxJwpeQwpyb290QG1p
a2VzLXVidW50dS0yMS0wNDovdG1wL2RiZyMgZGF0ZQpUdWUgSnVuICA4IDA3OjA5OjU2IEFNIFVU
QyAyMDIxCg==

--_005_CO1PR05MB810120D887411CCDA786A849B7379CO1PR05MB8101namp_
Content-Type: application/octet-stream; name="nfsv4.pcap"
Content-Description: nfsv4.pcap
Content-Disposition: attachment; filename="nfsv4.pcap"; size=474;
	creation-date="Tue, 08 Jun 2021 08:52:52 GMT";
	modification-date="Tue, 08 Jun 2021 08:52:52 GMT"
Content-Transfer-Encoding: base64

1MOyoQIABAAAAAAAAAAAAAAABAABAAAAuRe/YJSaAQBKAAAASgAAAAAADJ/6PABQVpPX2ggARQAA
PKJxQABABgS+CqKE5wICAgIC7QgBpmGEzAAAAACgAvrwk7sAAAIEBbQEAggKi1tG6gAAAAABAwMH
uhe/YGisAQBKAAAASgAAAAAADJ/6PABQVpPX2ggARQAAPKJyQABABgS9CqKE5wICAgIC7QgBpmGE
zAAAAACgAvrwk7sAAAIEBbQEAggKi1tK1wAAAAABAwMHvBe/YPPqAQBKAAAASgAAAAAADJ/6PABQ
VpPX2ggARQAAPKJzQABABgS8CqKE5wICAgIC7QgBpmGEzAAAAACgAvrwk7sAAAIEBbQEAggKi1tS
twAAAAABAwMHwBe/YPJhAwBKAAAASgAAAAAADJ/6PABQVpPX2ggARQAAPKJ0QABABgS7CqKE5wIC
AgIC7QgBpmGEzAAAAACgAvrwk7sAAAIEBbQEAggKi1titwAAAAABAwMHyBe/YP9PBgBKAAAASgAA
AAAADJ/6PABQVpPX2ggARQAAPKJ1QABABgS6CqKE5wICAgIC7QgBpmGEzAAAAACgAvrwk7sAAAIE
BbQEAggKi1uCtwAAAAABAwMH

--_005_CO1PR05MB810120D887411CCDA786A849B7379CO1PR05MB8101namp_
Content-Type: text/plain; name="trace_pipe.txt"
Content-Description: trace_pipe.txt
Content-Disposition: attachment; filename="trace_pipe.txt"; size=3508;
	creation-date="Tue, 08 Jun 2021 08:52:52 GMT";
	modification-date="Tue, 08 Jun 2021 08:52:52 GMT"
Content-Transfer-Encoding: base64

ICAgICAgICAgICA8Li4uPi03MTQ4ODQgIFswMDFdIC4uLi4gMTYzOTM2NS45NjI0NjY6IHhwcnRf
Y3JlYXRlOiBwZWVyPVsyLjIuMi4yXToyMDQ5IHN0YXRlPUJPVU5ECiAgICAgICAgICAgPC4uLj4t
NzE0ODg0ICBbMDAxXSAuTi4uIDE2MzkzNjUuOTYyNTI0OiBycGNfY2xudF9uZXdfZXJyOiBwcm9n
cmFtPW5mcyBzZXJ2ZXI9Mi4yLjIuMiBlcnJvcj0tMjIKICAgICAgICAgICA8Li4uPi03MDExNDgg
IFswMDFdIC4uLi4gMTYzOTM2NS45NjI1MzA6IHhwcnRfZGVzdHJveTogcGVlcj1bMi4yLjIuMl06
MjA0OSBzdGF0ZT1MT0NLRUR8Qk9VTkQKICAgICAgICAgICA8Li4uPi03MTQ4ODQgIFswMDFdIC4u
Li4gMTYzOTM2NS45NjI1NDM6IHhwcnRfY3JlYXRlOiBwZWVyPVsyLjIuMi4yXToyMDQ5IHN0YXRl
PUJPVU5ECiAgICAgICAgICAgPC4uLj4tNzE0ODg0ICBbMDAxXSAuLi4uIDE2MzkzNjUuOTYyNTU1
OiBycGNfY2xudF9uZXc6IGNsaWVudD0wIHBlZXI9WzIuMi4yLjJdOjIwNDkgcHJvZ3JhbT1uZnMg
c2VydmVyPTIuMi4yLjIKICAgICAgICAgICA8Li4uPi03MTQ4ODQgIFswMDFdIC4uLi4gMTYzOTM2
NS45NjI1NTg6IHJwY190YXNrX2JlZ2luOiB0YXNrOjMyMzlAMCBmbGFncz1OVUxMQ1JFRFN8RFlO
QU1JQ3xTT0ZUfFNPRlRDT05OfENSRURfTk9SRUYgcnVuc3RhdGU9QUNUSVZFIHN0YXR1cz0wIGFj
dGlvbj0weDAKICAgICAgICAgICA8Li4uPi03MTQ4ODQgIFswMDFdIC4uLi4gMTYzOTM2NS45NjI1
NTk6IHJwY190YXNrX3J1bl9hY3Rpb246IHRhc2s6MzIzOUAwIGZsYWdzPU5VTExDUkVEU3xEWU5B
TUlDfFNPRlR8U09GVENPTk58Q1JFRF9OT1JFRiBydW5zdGF0ZT1SVU5OSU5HfEFDVElWRSBzdGF0
dXM9MCBhY3Rpb249Y2FsbF9zdGFydCBbc3VucnBjXQogICAgICAgICAgIDwuLi4+LTcxNDg4NCAg
WzAwMV0gLi4uLiAxNjM5MzY1Ljk2MjU2MDogcnBjX3JlcXVlc3Q6IHRhc2s6MzIzOUAwIG5mc3Y0
IE5VTEwgKHN5bmMpCiAgICAgICAgICAgPC4uLj4tNzE0ODg0ICBbMDAxXSAuLi4uIDE2MzkzNjUu
OTYyNTYwOiBycGNfdGFza19ydW5fYWN0aW9uOiB0YXNrOjMyMzlAMCBmbGFncz1OVUxMQ1JFRFN8
RFlOQU1JQ3xTT0ZUfFNPRlRDT05OfENSRURfTk9SRUYgcnVuc3RhdGU9UlVOTklOR3xBQ1RJVkUg
c3RhdHVzPTAgYWN0aW9uPWNhbGxfcmVzZXJ2ZSBbc3VucnBjXQogICAgICAgICAgIDwuLi4+LTcx
NDg4NCAgWzAwMV0gLi4uLiAxNjM5MzY1Ljk2MjU2MjogeHBydF9yZXNlcnZlOiB0YXNrOjMyMzlA
MCB4aWQ9MHhlYzk3NmJiYgogICAgICAgICAgIDwuLi4+LTcxNDg4NCAgWzAwMV0gLi4uLiAxNjM5
MzY1Ljk2MjU2MjogcnBjX3Rhc2tfcnVuX2FjdGlvbjogdGFzazozMjM5QDAgZmxhZ3M9TlVMTENS
RURTfERZTkFNSUN8U09GVHxTT0ZUQ09OTnxDUkVEX05PUkVGIHJ1bnN0YXRlPVJVTk5JTkd8QUNU
SVZFIHN0YXR1cz0wIGFjdGlvbj1jYWxsX3Jlc2VydmVyZXN1bHQgW3N1bnJwY10KICAgICAgICAg
ICA8Li4uPi03MTQ4ODQgIFswMDFdIC4uLi4gMTYzOTM2NS45NjI1NjI6IHJwY190YXNrX3J1bl9h
Y3Rpb246IHRhc2s6MzIzOUAwIGZsYWdzPU5VTExDUkVEU3xEWU5BTUlDfFNPRlR8U09GVENPTk58
Q1JFRF9OT1JFRiBydW5zdGF0ZT1SVU5OSU5HfEFDVElWRSBzdGF0dXM9MCBhY3Rpb249Y2FsbF9y
ZWZyZXNoIFtzdW5ycGNdCiAgICAgICAgICAgPC4uLj4tNzE0ODg0ICBbMDAxXSAuLi4uIDE2Mzkz
NjUuOTYyNTY0OiBycGNfdGFza19ydW5fYWN0aW9uOiB0YXNrOjMyMzlAMCBmbGFncz1OVUxMQ1JF
RFN8RFlOQU1JQ3xTT0ZUfFNPRlRDT05OfENSRURfTk9SRUYgcnVuc3RhdGU9UlVOTklOR3xBQ1RJ
VkUgc3RhdHVzPTAgYWN0aW9uPWNhbGxfcmVmcmVzaHJlc3VsdCBbc3VucnBjXQogICAgICAgICAg
IDwuLi4+LTcxNDg4NCAgWzAwMV0gLi4uLiAxNjM5MzY1Ljk2MjU2NDogcnBjX3Rhc2tfcnVuX2Fj
dGlvbjogdGFzazozMjM5QDAgZmxhZ3M9TlVMTENSRURTfERZTkFNSUN8U09GVHxTT0ZUQ09OTnxD
UkVEX05PUkVGIHJ1bnN0YXRlPVJVTk5JTkd8QUNUSVZFIHN0YXR1cz0wIGFjdGlvbj1jYWxsX2Fs
bG9jYXRlIFtzdW5ycGNdCiAgICAgICAgICAgPC4uLj4tNzE0ODg0ICBbMDAxXSAuLi4uIDE2Mzkz
NjUuOTYyNTY2OiBycGNfYnVmX2FsbG9jOiB0YXNrOjMyMzlAMCBjYWxsc2l6ZT01NiByZWN2c2l6
ZT0zMiBzdGF0dXM9MAogICAgICAgICAgIDwuLi4+LTcxNDg4NCAgWzAwMV0gLi4uLiAxNjM5MzY1
Ljk2MjU2NjogcnBjX3Rhc2tfcnVuX2FjdGlvbjogdGFzazozMjM5QDAgZmxhZ3M9TlVMTENSRURT
fERZTkFNSUN8U09GVHxTT0ZUQ09OTnxDUkVEX05PUkVGIHJ1bnN0YXRlPVJVTk5JTkd8QUNUSVZF
IHN0YXR1cz0wIGFjdGlvbj1jYWxsX2VuY29kZSBbc3VucnBjXQogICAgICAgICAgIDwuLi4+LTcx
NDg4NCAgWzAwMV0gLi4uLiAxNjM5MzY1Ljk2MjU2OTogcnBjX3Rhc2tfcnVuX2FjdGlvbjogdGFz
azozMjM5QDAgZmxhZ3M9TlVMTENSRURTfERZTkFNSUN8U09GVHxTT0ZUQ09OTnxDUkVEX05PUkVG
IHJ1bnN0YXRlPVJVTk5JTkd8QUNUSVZFfE5FRURfWE1JVHxORUVEX1JFQ1Ygc3RhdHVzPTAgYWN0
aW9uPWNhbGxfY29ubmVjdCBbc3VucnBjXQogICAgICAgICAgIDwuLi4+LTcxNDg4NCAgWzAwMV0g
Li4uLiAxNjM5MzY1Ljk2MjU2OTogeHBydF9yZXNlcnZlX3hwcnQ6IHRhc2s6MzIzOUAwIHNuZF90
YXNrOjMyMzkKICAgICAgICAgICA8Li4uPi03MTQ4ODQgIFswMDFdIC4uLi4gMTYzOTM2NS45NjI1
NzA6IHhwcnRfY29ubmVjdDogcGVlcj1bMi4yLjIuMl06MjA0OSBzdGF0ZT1MT0NLRUR8Qk9VTkQK
ICAgICAgICAgICA8Li4uPi03MTQ4ODQgIFswMDFdIC4uLi4gMTYzOTM2NS45NjI1NzE6IHJwY190
YXNrX3NsZWVwOiB0YXNrOjMyMzlAMCBmbGFncz1OVUxMQ1JFRFN8RFlOQU1JQ3xTT0ZUfFNPRlRD
T05OfENSRURfTk9SRUYgcnVuc3RhdGU9UlVOTklOR3xBQ1RJVkV8TkVFRF9YTUlUfE5FRURfUkVD
ViBzdGF0dXM9MCB0aW1lb3V0PTAgcXVldWU9eHBydF9wZW5kaW5nCiAgICAgICAgICAgPC4uLj4t
NzE0ODg0ICBbMDAxXSAuTi4uIDE2MzkzNjUuOTYyNTc2OiBycGNfdGFza19zeW5jX3NsZWVwOiB0
YXNrOjMyMzlAMCBmbGFncz1OVUxMQ1JFRFN8RFlOQU1JQ3xTT0ZUfFNPRlRDT05OfENSRURfTk9S
RUYgcnVuc3RhdGU9UVVFVUVEfEFDVElWRXxORUVEX1hNSVR8TkVFRF9SRUNWIHN0YXR1cz0wIGFj
dGlvbj1jYWxsX2Nvbm5lY3Rfc3RhdHVzIFtzdW5ycGNdCiAgICBrd29ya2VyL3U1OjEtMzI1OCAg
ICBbMDAxXSAuLi4uIDE2MzkzNjUuOTYyNjE4OiBycGNfc29ja2V0X2Nvbm5lY3Q6IGVycm9yPS0x
MTUgc29ja2V0OlsyNTA2NTkwXSBkc3RhZGRyPTIuMi4yLjIvMjA0OSBzdGF0ZT0yIChDT05ORUNU
SU5HKSBza19zdGF0ZT0yIChTWU5fU0VOVCkKICAgIGt3b3JrZXIvdTU6MS0zMjU4ICAgIFswMDFd
IC4uLi4gMTYzOTM2NS45NjI2MTk6IHhwcnRfcmVsZWFzZV94cHJ0OiB0YXNrOjQyOTQ5NjcyOTVA
NDI5NDk2NzI5NSBzbmRfdGFzazo0Mjk0OTY3Mjk1Cg==

--_005_CO1PR05MB810120D887411CCDA786A849B7379CO1PR05MB8101namp_--
