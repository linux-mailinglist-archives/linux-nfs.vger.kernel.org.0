Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988DB507842
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Apr 2022 20:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356733AbiDSSUm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 19 Apr 2022 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356734AbiDSSTs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Apr 2022 14:19:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2013.outbound.protection.outlook.com [40.92.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739993FBF3
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 11:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W97JI7h4lD2bdqbbiEVTHbcq38OtQT6HcAdZU4QzY5GvUgUkIsd4BjKKP+5vFHjCXaABfWVmFc0dhnnbTB6qcmVxL/bdkdsG1499bY8dLf90+bfEmO5f50MWy7TlF7ahGIfkqGMKLBdrNYErfMHLs96amZtQ+G584o2pGuVRTPnBcii4OIhSrOLa3JMQJFSsJJfiTxFbyXRFiNM/hq+V1yYT8T/aXFTnag9WY7tJdzGDqwu7jo4VDN9FF5sA7CDgZH9OMaxDOMtSk72PB1LwuSq2WYc2XMiVJ0wBp+Oy4+cY4NIYfTd7VsZ95Emfk0IAqEO/bYYy9ndfHonI/y6pLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgIhK+KJH03dZs6Fb3BHhPYbwBdvHZ7+P3mRarPO8dQ=;
 b=bHd51wnu98B4Jk+/NO8cI6ueav03BgdlThLABviLVVXae2epnzO+OqsaSDihb7irsjMpchBT4eJzNrMS2TKdEKr5b5wnz0TMZf9NnktvoykLT+oZ9SN/BiDU6jADLbxaMmJl3/HOR4kNdI/qpzfih/kvRMQJcwF6YrmsN8qGOk5TMO+QpHjzdEKbuFCwH44rCVH3dCjW6cPgzmNAuoMukF3u9CkV2UvaJJ0mmvlFjgXrcDTjQO7UBw6o7SXFWl1CIqKDKbla6TaRiipnDtIPicEXHqJSqZhGowNGaU1NONcmM5CL6P8dt3jEYR4zCks+R3VbO94SPBl/xURTon0uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:267::24)
 by PAXP191MB1776.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 18:13:47 +0000
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a]) by AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 18:13:47 +0000
From:   Andreas Nagy <crispyduck@outlook.at>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: ESXi NFS4.1 issue
Thread-Topic: ESXi NFS4.1 issue
Thread-Index: AQHYVBGFaw+YyKGBpkmYsCuhuUrPP6z3igUB
Date:   Tue, 19 Apr 2022 18:13:47 +0000
Message-ID: <AM9P191MB16656CBF8316ECB4EEBB9E8A8EF29@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB1665B57A3D3F234F676924408EF29@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB1665B57A3D3F234F676924408EF29@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 4ad4f4b3-130f-b2ba-a7b8-cb33e44389eb
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [VXlrHjPlSYwLgnYcMFT90nG6nXzP7EMv]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffdbc5b6-53a9-4622-218d-08da223058dd
x-ms-traffictypediagnostic: PAXP191MB1776:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQG8jUDj52f6lOlVwm5pUt4sNvk5WswWodYhYmGp1hJxTBYCFxg+IRZv81sTZG3cwvLF9HxV+4NFFwic1jYxxlR0nUOUbYhLBX3dTQGknYnDfIpTHIYVAm5Z0NZbjk6EDfexSCs1nwPWC8x4V1oywyB0cf+OpDvKx9/gSowsBUdvtpDeNTXriStfE9cTWdOmgALvVHW1NsDvGiuUCKgf7/U1n61VSmKSnHGkDUbIwY6Q+0cqikXnNtScSa5DOryAuVH7Xa2zvgpMxsfYkdQ/k/xBUvkSHvINHRuF4X+EamDZXd1dUgI5YRscetZ7D2AnB+w6S2FResVdPg2+yz8oqsNVwv7d7383Xl6jzjMyljQimcEmFTW/gqlzdGfyDKaPDxHhBdmMLT+Ve768YCVHj3vZdq2jO9pC6VzbI/oWy4yHfRKOgZG0DNKhDCSflrghJAfVoUeTWKcSAwB7CGSHeAxx1UK/kuCz8k3Tm1jKvccQSV95ezydih3Z5c4TUFR7b1rpOgfijyvB7OTIkB/eTw1XF7ul9q2oWypTmPS31t9YFisN9ydi7I7Dy+JhGVdLsTUpzMZO2zkg4QM9M3yBZmz6Sy+q5XfYOfUCt0/KasGEUNllxPiY+Kx1QLChVTJW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QOfsQxgREodM+aI17U6Hsvd/PkroKusCnty+ibhN7GMGACDsq1aYBMeSLR?=
 =?iso-8859-1?Q?UMK0z/btfE7DGEhGDnBUiiHFXeECwFFQuW1Os9ih6PfVoJY9FoT9iVrUno?=
 =?iso-8859-1?Q?uI7htmL9kgU6yEwOb+6XwypcHjTyf/ffLhcjUIMgOSTCvIum04QCDUKHlx?=
 =?iso-8859-1?Q?iUmeKJIz791Z02IyPc6igtUI4VSfuS2o21Ks5ljvVbo5BzRN8A3JNUmqmX?=
 =?iso-8859-1?Q?5YltgosQkoaGo6Dw0QNZ7pXccgihipwLU4/FJwNThDj17bN9kuXmUxdXiI?=
 =?iso-8859-1?Q?JiLyUj6xJCfTd3WmgjMZNqtFzQG/dXWkdpsfHJMztbngentyEGtlOm72jO?=
 =?iso-8859-1?Q?74rB1hy3ClHCBFnHE4AFgS9vPtEGptfZW+GLCX12WDnV10qCdJgh78CODJ?=
 =?iso-8859-1?Q?CWXCAJhi/8OxC2cGw4+FGCI0+z0aO9VvDW8v0ZjIhWEgcM+APVWNFIy3wi?=
 =?iso-8859-1?Q?/Utid+HjBYNPumMDQFhflnWPBV0ZnPHRG2iC0dQa4BA5UcPU59JJGAz1lB?=
 =?iso-8859-1?Q?RHTbiRLjI4nnwfytcIS4Aux1cdB1FqdjwuIEEc9KxgdJQQa4BXVXwDxzf+?=
 =?iso-8859-1?Q?Yx4BZBOl3hC18sZSaJIZ0bbADgZLuR0or4LtGf4QZ4gvyELtzzYUKdSP1Z?=
 =?iso-8859-1?Q?gCbmcapmPZG8GMh8pSCmE7zMC1FHtVKdQ29WO4JfVxPasO842b073fuv7k?=
 =?iso-8859-1?Q?8FTlzI+fb96Qnzx0oajjG+3G0kEOpAqornaKR7oAMXve00DS6uq5KvTwiC?=
 =?iso-8859-1?Q?e/w/kcY+M8osyNN6gf2BIfJBl6Ydb2NGWPxXG9d+/srvMoGmHgEaMwTGge?=
 =?iso-8859-1?Q?fHNAL0lCfWq+iUOpkz7YBC80g/bgqhHRpMiEIrwPnxI/djx40lXLVcirSe?=
 =?iso-8859-1?Q?c7OI/AZEa3RazBDVD8Y6IieJHHIy5icupaajoZnYQmFscvbqG44vWfD7Pc?=
 =?iso-8859-1?Q?nhIJM4OVxBQmx51V3038ARo0OyLJDCBVtj4zwWJWTNrXOUCBPRwvSqJvJ7?=
 =?iso-8859-1?Q?Xikg7Vt5wuafT8O/HkbkJoch+VwLhU+bAljRxMwjQkqp4BZgI9HxnwWEGO?=
 =?iso-8859-1?Q?u0RV2Ifknnd0GnMRwiJOYB2Lt6V6EVjrLnZT1ZdduaNYQwm1yYthhZpQaw?=
 =?iso-8859-1?Q?6TZBK6C9C/GY6ZPsc3+nIaCXYXp7NdYSYVKS1VHVFmImH3aWqJnhr2KuqD?=
 =?iso-8859-1?Q?SsEWckIJjyQ9F07bz98XffVXIyqP6v+be2weRJQaU7yhlNBZvCd+IJWNHR?=
 =?iso-8859-1?Q?yZPGntlnS/vraQBJ2Y6Yc5HMd33ZDQYRA6Sl1+gwZ5IMpIdS8uKcZwmtSl?=
 =?iso-8859-1?Q?GLxZgZADXNFynHMLvGUu4B+9RqlM+T64gmZ+RCc6aFzJwhb32YV5/tg5WD?=
 =?iso-8859-1?Q?NcZHlt8LIgYUbNLh0szCzoCpOEYgktC4MslvFfInwk+MGACdJFjXM2pnOA?=
 =?iso-8859-1?Q?g+twiuaWGZyIJmCHd+WPZxi2vQpazZmjkxn6Hw4wdQs8E3PXjcJFju4U1+?=
 =?iso-8859-1?Q?s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdbc5b6-53a9-4622-218d-08da223058dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 18:13:47.0383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP191MB1776
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

tcpdump taken on the esxi with filter on the nfs server ip ca be found here:
https://file.io/rtFeuFGlYY98

I tried to analyze, but have no idea what exactly the problem is. Maybe it is some issue with the VMWare implementation? 
Would be nice if someone with better NFS knowledge could have a look on the traces.

Best regards,
cd

