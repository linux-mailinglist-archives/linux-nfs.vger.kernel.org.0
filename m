Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAB750961D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Apr 2022 06:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbiDUE6G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 21 Apr 2022 00:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiDUE6F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Apr 2022 00:58:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-oln040092074033.outbound.protection.outlook.com [40.92.74.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29BB2189
        for <linux-nfs@vger.kernel.org>; Wed, 20 Apr 2022 21:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zan6MZ8UiNNbKNJzAeORrelynHZdkT2NVqCDF9PGSca+ToM65ouyFML5iz2cJX7gGmsYGpvh1x+BduYf8Mwc0kB+L73jFTShZqk+KI6eBa2zdRR2njnaioqEJDi1xTSxfyDP5BawRQk8TtAMof1Ef+FGXCwF/CwSUGHxjxpbSKgJu0J+vBTq3qSLDj3IJAO0mjt6blrtM40Xc8x3TdaFjShp6v065wnQgPVd3QUabgWlftVYML7fLy7+a8dKzsVO9/hoEHo4uQbbHj6hFk4GZKsgBtFVD0+NgK0lFAEwaqKfPqvUs0qqj11uRjWN1ulz7M2bqn986L04r6bFpWsxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNHHL3GlXUIkKa0fM/Nb2cYddcsXdJko0Ewu4LFKsRk=;
 b=TbofQ94+ZVIwSQEvxwAmBmzDRSn1yarRMCT81RqvwD0jatxGhmJLvQRm60eZvc6Gj3Khi82fVz0B2HzGt0CX9JUxBWXPfVvGzTWAh4iQun2BgKDGvLTFi/v9aloQ0gSpC8igcYqr3HwQre1d4+IkIHkBFKK7aIcX7P5ljbTe+eu6ZnDvtPJmyKoXr5e54Y36kS6q/yoQIGJdWHrmqA6+WYv6oTEMwMgzXT3G7mMjLjBOGGOZ40/12GEAgLEtGSePO6bHx3XSgJgej6q3X+zQmwKcicCz6CHgatc0O12C/Qn8td69I4tMjJOwfmWaqIXexBOYJMP4Zr1AMCbkilh8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:267::24)
 by AM9P191MB1746.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:3e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 04:55:13 +0000
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a]) by AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a%5]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 04:55:13 +0000
From:   Andreas Nagy <crispyduck@outlook.at>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Problems with NFS4.1 on ESXi 
Thread-Topic: Problems with NFS4.1 on ESXi 
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5
Date:   Thu, 21 Apr 2022 04:55:13 +0000
Message-ID: <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: b20cf64e-ed06-43e7-aff2-11a85e147aba
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [T3nyuyrz6cNIaw57L69LHxPv+1broD1X]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74d456f3-9bba-4df3-d656-08da23531f39
x-ms-traffictypediagnostic: AM9P191MB1746:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: soNpHLMolbYcSZRBbjJOaeFjtm4BSaKUGeGeCzYeNk2929z+sOjHwP7GOP9gR8m6peAc6QNT43bjtQ+wiSNNwl1kKY6AhcHCazjVKfmgI61WzKaBTCODAPhPJdevipjaWFmbST59MUvVmoNBcn9vQi8EG2pBeR+bJ/5mx9Mm2P4XPZUDcOrGXMVBIKlfM0kg9ir+Rpr+HfHHS8Jes97DL3gNGyV7GxMblKk9EIHHRIN0P92LWXSQhAVK02zQ1xgeSPuWM9C87poDGnqIRKDu5ZB1gNWp+sVb5mpQ3Drml42GiKpwZZQAe2HwPmAenwAZFWwDMTR80lh9T02ctNhfuQAgh9XBNlNeQQxIAqJwP8KdD6KT2FWzcXhUA1y5CH396B3+g7RN1DqxZVHtxuUaNF9xZqFT36GdM/s1dsdTWiImqShMZj7A+vmzO1QQz042P9KM1GaJt//mVZwXAqxgQ58PdNfEGhU6GDR0zejd6Y0yTRHrz9m4NHREmR2iS8sCxUGLfgJyr86oSWdsT43DlJw4/x5lCsN4YaIXwF/EzyUIv2AL4uC+adbyKkevtcj7qpLjr6TEK5bPUwd85Rp+egOiCBI/EMF6e9DTw8/C/HIUY8PF76HQXJNNL2OBtgxc
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MzcUspTemIeRuHlyushA5uNiKhKgHSg1jTTwSKvO6hRtAi1UFo/eqSugED?=
 =?iso-8859-1?Q?aqxWGbqJFl3rtLzKkhX/KVZIEvAoIKvJwrW6YGnEmL/yIoV9qd9biI11Ti?=
 =?iso-8859-1?Q?pW2fYlUet6mjCCSKVTkPPGM9pTZghPyy9TxM6jMAUPTlhNxQIB4u4GcxTl?=
 =?iso-8859-1?Q?J614/g7Cugca4NdXsuTJYLqHUJo8KJMS7+ioVwepbnKjWF8aUNfU4bk3Rf?=
 =?iso-8859-1?Q?LrCnjTiDJwL7mFvakYFo6aOudBV0QDoAZvZn+XECv6AR5iG0IbK1SqVFin?=
 =?iso-8859-1?Q?QSSu0cbiG45pc8jOKixFJZ0vArh9XyHwDMpSws7PkIxulGIDmgzCtJO54I?=
 =?iso-8859-1?Q?MDnsGqnJI/dRudf6VbDMEEiHu+wCmN4B0n4blGlJTg0H+L80mLudjzIEWz?=
 =?iso-8859-1?Q?UJeRbqVRV6AZm1HFdD1g8PdWcvYxD/0nG/cMc1u4PLx4mjo6Hmh07nsV2q?=
 =?iso-8859-1?Q?i7kbwzOh0OngPucMppgm7tSo21zCT3QhicD/k+JBTSUN3IqrwpL09ns5Zw?=
 =?iso-8859-1?Q?snGZu+kFDDjkt0F5b9NEZUTAe9YSXIGXTZMcW9BVkw4gjlpA6UKZVij3xx?=
 =?iso-8859-1?Q?2KG+di2rRastMwXwIDLEw4EToPdn3BYrHgESvddcPqSd8rbh/Ej5eLdLV9?=
 =?iso-8859-1?Q?AFIwCcaC6aukmdk4iPxyZnfZEaZSsYRFDLvVw3S1/2eS1TOCTUc8XlraeZ?=
 =?iso-8859-1?Q?wN9ZO4GBxDtwE3Tqs90L2cU3ypjWLVppIPzve25qnbIQPYoPkMG+UNjJb9?=
 =?iso-8859-1?Q?CDDp+ChSH69K8+Nqc7BtxfbCAPadcj3sdNZOJ0DLI8UW2Z9CfDzfy7tpaC?=
 =?iso-8859-1?Q?e9zDMbk4QaUqkXGfqgHqySXxIxuLhKR1+DG4pzXaGoEl/9kgPBkSMamDrh?=
 =?iso-8859-1?Q?TPi8pHfchYFwoMqBthggJPJ/ODoC7R0YKvikCwVfiis2dxgmq7KmUECV40?=
 =?iso-8859-1?Q?MSIXMMPV1v3IcwA2Wse/EIbdtULXtZHSFcwLO5HmJCz8dnhkTufKp8xDQK?=
 =?iso-8859-1?Q?TJUgcQNoa43+exCc4NoguPCno4vfeC7csG72VXIwDPts3buhTgzaeF+R5X?=
 =?iso-8859-1?Q?6xRQQS5qDnkQRrIhCXWqQsu3f7VTv33skj4xFNXu997DkRQlp3DXFMpUZk?=
 =?iso-8859-1?Q?t0unL/Xxr5qrpoJ8qEq3QNpDllz11rER7jIOElAI2ZaueAg/KbIMrCP6Nu?=
 =?iso-8859-1?Q?L4wz+Hg5kZAS7z9unDHSO0ZhdyGIn+GqAFroZeOvQVq1MW4g/e2JOT86HC?=
 =?iso-8859-1?Q?zRuFF2hpC08eIlVVPMKQTNp8G0wj1mgygoNIt6e+aQPy5S38y1+7U7fURn?=
 =?iso-8859-1?Q?7Te2XGmBbaD86gUCySza/uKbf0WE3W2caxaiYUduU39jqr/ypKEd4BXzUG?=
 =?iso-8859-1?Q?tGfKSvUxeT291JFbIJpyngF2Tp+rIX5EpQ4iQgSzaacl9AM/iXOjL66DNH?=
 =?iso-8859-1?Q?PNF5FN3Dve9g9Qb6xg8PAESM/PETPSBcZBzjxGqUZKMppM2AcesQ2UAM82?=
 =?iso-8859-1?Q?M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d456f3-9bba-4df3-d656-08da23531f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 04:55:13.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P191MB1746
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I hope this mailing list is the right place to discuss some problems with nfs4.1.

Switching from FreeBSD host as NFS server to a Proxmox environment also serving NFS I see some strange issues in combination with VMWare ESXi.

After first thinking it works fine, I started to realize that there are problems with ESXi datastores on NFS4.1 when trying to import VMs (OVF).

Importing ESXi OVF VM Templates fails nearly every time with a ESXi error message "postNFCData failed: Not Found". With NFS3 it is working fine.

NFS server is running on a Proxmox host:

 root@sepp-sto-01:~# hostnamectl
 Static hostname: sepp-sto-01
 Icon name: computer-server
 Chassis: server
 Machine ID: 028da2386e514db19a3793d876fadf12
 Boot ID: c5130c8524c64bc38994f6cdd170d9fd
 Operating System: Debian GNU/Linux 11 (bullseye)
 Kernel: Linux 5.13.19-4-pve
 Architecture: x86-64


File system is ZFS, but also tried it with others and it is the same behaivour.


ESXi version 7.2U3

ESXi vmkernel.log:
2022-04-19T17:46:38.933Z cpu0:262261)cswitch: L2Sec_EnforcePortCompliance:209: [nsx@6876 comp="nsx-esx" subcomp="vswitch"]client vmk1 requested promiscuous mode on port 0x4000010, disallowed by vswitch policy
2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)World: 12075: VC opID esxui-d6ab-f678 maps to vmkernel opID 936118c3
2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fce02850 failed: Stale file handle
2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fcdaa000 failed: Stale file handle
2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
2022-04-19T17:47:25.166Z cpu18:262376)ScsiVmas: 1074: Inquiry for VPD page 00 to device mpx.vmhba32:C0:T0:L0 failed with error Not supported
2022-04-19T17:47:25.167Z cpu18:262375)StorageDevice: 7059: End path evaluation for device mpx.vmhba32:C0:T0:L0
2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)World: 12075: VC opID esxui-6787-f694 maps to vmkernel opID 9529ace7
2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx

tcpdump taken on the esxi with filter on the nfs server ip is attached here:
https://easyupload.io/xvtpt1

I tried to analyze, but have no idea what exactly the problem is. Maybe it is some issue with the VMWare implementation? 
Would be nice if someone with better NFS knowledge could have a look on the traces.

Best regards,
cd
