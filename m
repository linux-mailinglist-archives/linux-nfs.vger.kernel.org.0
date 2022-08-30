Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7945A6C13
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiH3S0l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiH3S0k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 14:26:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015113F6F
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 11:26:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UI4Ejs002223;
        Tue, 30 Aug 2022 18:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PVLV0nf1psAVJPepJdYEzvybhIOi6epNHXVldABVHv0=;
 b=Pjh5TWijHUVeib5NslaxBfYLTHNAfd1Sss9SRcsARal+CBoCqKUCEC9Qv4ygiquJU5Bu
 rlx5AA2lNwFVpgNFdVK2GK94GlWbU23Ws2zX5jM+FObn9B2J/mRF9T3LD3ph+I8bi89L
 ShJTjCbYUiUjn/R7bpCAaufucXxIRte/u3ELpkYz8BkmCwvfLySPWymTKWKg/DjVY6rN
 X3AcwVkUAD0VMZCmtjOJA950cObQyT6EFKLi3YhuCYWm0fM/3MhD2Xt0JjR0mex/4iYW
 +vhVJlrCemCzuFxdPdpi+vFo6lg+6PIESuUUdUcrb8+otWsOq39yooy+1WqzsqyKoJfW 9g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59y3sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:26:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UI6rSC028341;
        Tue, 30 Aug 2022 18:26:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q4fqgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:26:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFFPHkg6zspyinLQznDPNVCHaURu8MKyTxAnojCTYgzyuoRjVvG4oFIQuBZFd8OlcuwTAZZnb+IY8WA3YOAAkRj8mFBFzC3cWQTQ3K2JcTGcO2qPiIgTELhf/urHiGAVVDEhaQ40qIqc6Fa5aFtZYJGgHo8pStf3mbqmulzuhFKvbLF8QQzbXydNanrJjIWeFT8Ljxy3TndsiOZ76uiDj7E9dtYfKT7eHBewSbmWsAMqxYQsmk0Bb6yky2If67757bfbZW5MV5Y5Ql46n8EnQ3oPCEinYpvAdpRISlYCqswHsPLkblPPi5zsTBOYmA1YUw8hC0vRj7HdyyVLHK+rJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVLV0nf1psAVJPepJdYEzvybhIOi6epNHXVldABVHv0=;
 b=jlUT/4o39bU33elkjvNDSg3DxoCyv2ySgTx54CnNYNxWz0suZ8ifzlWoTGRU6blZlNh87A4i6/AshF1QRhOQ9D9hUGvhWqFwijRihIQ+486Ysv2g3iMPcTjaJISAqONB4diq/XTKimOQW0J7meyaaNxIsR8bkOdbB8y9gXPLUkysL0/1aN9WIhyKfvKZRo5qLVkn4qit5cHlTXsd2o6SrBPXLJzyBIvqtMKaeTgvi5fiktAve1Ajb0mXWrC03DA698JY0EoDRIrrJxLy7iEBRE5gEq4v2p2J9LC19sChOn8MyFFZ9yHKQj1kMalLLRogk2yTR5V2jPINxK2UdyVNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVLV0nf1psAVJPepJdYEzvybhIOi6epNHXVldABVHv0=;
 b=mIGkiTNV18vEBUXML/GdV6fvPk/n/p8vySejcABoklAad9XaVTH0DOfEb2PEr32y1Jh8UqsynM2CePjPYrRADQ/gd8v96EtmrATW33U86czQYpa0126BOaHrWWxkaElUO8VOY5LrOOtD8LH+Xh9/z280P4QjFJpwKEVMwWVC+Cw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4373.namprd10.prod.outlook.com (2603:10b6:610:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 18:26:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 18:26:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Thread-Topic: Is this nfsd kernel oops known?
Thread-Index: AQHYvJP9R6JamLcYaUyLf/owehh7vq3HuG2AgAAJRICAAAEjgA==
Date:   Tue, 30 Aug 2022 18:26:19 +0000
Message-ID: <74A58EE9-DA83-4C17-B270-110EA11844E4@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyGqK1NsWP42+ZX-wpBrd=u2g9mQB8PZiRQqWTvp-B+6qQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGqK1NsWP42+ZX-wpBrd=u2g9mQB8PZiRQqWTvp-B+6qQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b0ab024-4ffc-48a8-b57d-08da8ab52205
x-ms-traffictypediagnostic: CH2PR10MB4373:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H6JvsHIlV1WEO376piMBHDQU4uZeBWyOk4iFiqZUOqXrWUrey5+8wbKnVdzNzBf2nnuq3AVLB4CH90FLL+EwaCS6QejESqXQmPktuEnM1XsF6I/FzTqqc5kMeLZGnhkSjbsbbUXrXLKh0oeMnJi8VvbAnWwmwEH+DSSgYw5Wo1s53yJgSbuf/YhxKSfhlDwDvw+Wn3ik4/Y8DP5sImTgLoDw+uLqIZoI70YMl+y9aUGBNHBV/dDKFfmgkbJsq/Aq+dy5g/Ym4iVhWq16CEp+XduKPu5TSRfP9ZCO1CBDVaqvqlu98AB/gtXToaqm3MiI79wqRXIu/W9WGl+pLg0ZT8+V4KQb85HNHbsk/33mghbSTm1Gbeb+yzc7u44CMTlGyrKeiGmIXvFez9IooRhdjFh4jeisS2ZfhJ8WXHHZdNmdYfhaaQVlhOXMDept6uMDWvzDVyXIfoMa2Z6kHZ0wTKOmbD1172kVIr/SSoZOdtq9hxI7CRE5Z1Dm79MXXJBO0f4L2qbm09cO9COGNvb5kRU3xgXX1kk8KmQIVXiDrb2hS3iE6X36MprZS82BYw/LpvQJjLKvPh1Q6bQO02WA8zz6LtRBiq82p+KJX9NYBr+BJRriMQ4edBwA8gpCxpwrTBn9UDJoIWDr6FKC1aZSBibjnSiXZWqV220ZB7aGOhyvvtBKm/nalLZIkObXanMtPecM2fBjjYPI83ekc8Y+JzhkTE+RoOR0XRdMI3pR6MlFL+ZEqnQaG7CCG6lbeRHlCQNIC7qkEy+yrEuGqAfuDtDeewq8qrkhEw3h36xIpiM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(39860400002)(346002)(136003)(45080400002)(71200400001)(38070700005)(6486002)(8676002)(86362001)(316002)(6916009)(66946007)(54906003)(66476007)(4326008)(91956017)(66556008)(66446008)(76116006)(64756008)(38100700002)(5660300002)(478600001)(36756003)(41300700001)(8936002)(2616005)(122000001)(2906002)(6506007)(53546011)(83380400001)(186003)(6512007)(26005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4sYSV2bvazPjspstJ/5/8gONizJLTzXAKuRfod1WcHpZAf23HfUbld2zeqem?=
 =?us-ascii?Q?GppEiE6Awy+lZ75j8C942uecGsfqL5jU4jDOMwZQrjQdKjPlI+UtCRptqlgl?=
 =?us-ascii?Q?RpDMwY7tEOLDb8JLlDUCwzgnZ2nodPoZPUEnpBrW+Kth04RfLnkm9KAF35++?=
 =?us-ascii?Q?jY8z3toJ8+DtkqHsUuVSfQgmtdj811LuOqQOJEuQOSy7wMgDGI4wkUqFXhd8?=
 =?us-ascii?Q?08pHcxWtPaICpxARyrKTquNFoboALjgaQYKblzHcjfQCpmed1ONFE2Pcomad?=
 =?us-ascii?Q?Z/KW7wp2BnahOeN3GbAc/5wZ5HA5Vbe0W7Ct5K72VmZ8Xz+8GKYIWIR2L131?=
 =?us-ascii?Q?7K2UjjqWUuGSPItnsc7DzVlcdDEwdHtng9xYlvAmhna76wxcHqmkcpqbfKiU?=
 =?us-ascii?Q?hETm9eZvGdSumLY7fnHA4n8tD3qSvn2anjv6c+prsxHUjoS1R12Elg2Xevkm?=
 =?us-ascii?Q?DzkmgMgR/52FHs4CIDdrywflFQ4LNWoihySCztg0bDrxNWBbZAxAbg2/xNfo?=
 =?us-ascii?Q?1h0btnjA1u3ir67oIEYlRQAgoW8hI9CyUM2XLLf2oNwacQK7ppchOOi73XQ3?=
 =?us-ascii?Q?q1dA2EfT/whVnq9OJ4/aRiyd736GN9QVORS8kj8wnkcHj+YAS1hsP4y6wvJh?=
 =?us-ascii?Q?8vDKKWZOdHvCtaZeDU9QtUZE0U5r2sPSrIxSJZwCM9VMnfa95pVXrMNw5iU9?=
 =?us-ascii?Q?OVPuRuhg9DkUEy+0G72YT798bDybhbgqokRXDHDe8gj5QPvaNsMNWxpYSXVg?=
 =?us-ascii?Q?AJg6MdI654cviNAOpoznqsnnBdFJg8AooIBFYpZp7PThetqtpOc2tyMqdgbk?=
 =?us-ascii?Q?A+U649LdH+y2UM3vlF4y+WZGUKXDX2eDJltTKewFNwgGeBvv0RarLoZ8bMJR?=
 =?us-ascii?Q?HyBAu1Q0Bsdmneqjrnomtv6s0ag8nIG3emHfl7qTONU+42MdL6G6XA0E/+Dc?=
 =?us-ascii?Q?rEWSCTEkEWCnacEdioNgQJbbnxIDLSz+SRyG3pb2X8TherY5IpO5FepLerzy?=
 =?us-ascii?Q?2J6Y9MiKZ8evrAOCKqCO9TyB4Vpxk/Th/4b+bqZhLbWQUFhkWdRFmlFWTJrS?=
 =?us-ascii?Q?859yZBccABy92Tp97UswM3ZabsUAvZ7Iw11BsPoJ4wD563SmOFrQNX1OSXn7?=
 =?us-ascii?Q?xnYUXMb+W225V902lEJu8MalSiKbrzCKEqfzbrcTyfdEuBTVBnykCdkFBu+f?=
 =?us-ascii?Q?cpbFb1aoQT4BuBcpY20zAO4dStWHFnxOwebAub9vxC4WQJXtEnQ959b1YirE?=
 =?us-ascii?Q?CB1meVvzp2dknxc3en2o2wLVnAThzef51otgPlBWR9QM1Sh8osnAhFxeJS03?=
 =?us-ascii?Q?oo8bOsaLCRNFdbFSUaZzFrZcdnpuYr7lIvl1+1on+pRsBk2S8z7XjwnZgkD+?=
 =?us-ascii?Q?a9SFR74bQb9ajLuNo7b5V0O0E3J6wGYLln4kiKlsdMMLGr+qqM39qubVWJ0O?=
 =?us-ascii?Q?n4XfGGXsdlPNdtjHSl2mTwu6F7gIqfzLJxkD+vWKHjFTj3GWr+6gzoqoKDcv?=
 =?us-ascii?Q?ppinjoyRPTouS5K8ZxF28LXYCP9VhGVRRD/AGYMomlGsv/57Q+xTcTRgu+kA?=
 =?us-ascii?Q?+lFDOt2MlOdXBvi3/z+cTBQ1NgSPSJK6Qk4JrUeiNzC/2Pz9pVc7K+8KRWsF?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <070B56E87BE3274397311F418C96B522@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0ab024-4ffc-48a8-b57d-08da8ab52205
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 18:26:19.0221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGYs1u9eAZ7NdiFbaX5jkBp7f3Hy/jZX72T+byWF0eqaV0X0UcClNYzZeS5fwasDpQPPwkQnHtwDwZ2HQyfnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300083
X-Proofpoint-ORIG-GUID: 2Rv8gpxRUuy7ZADNScpXAQtglPiCIY45
X-Proofpoint-GUID: 2Rv8gpxRUuy7ZADNScpXAQtglPiCIY45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 30, 2022, at 2:22 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Aug 30, 2022 at 1:49 PM Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Tue, 2022-08-30 at 13:14 -0400, Olga Kornievskaia wrote:
>>> Hi folks,
>>>=20
>>> Is this a known nfsd kernel oops in 6.0-rc1. Was running xfstests on
>>> pre-rhel-9.1 client against 6.0-rc1 server when it panic-ed.
>>>=20
>>> [ 5554.769159] BUG: KASAN: null-ptr-deref in kernel_sendpage+0x60/0x220
>>> [ 5554.770526] Read of size 8 at addr 0000000000000008 by task nfsd/259=
0
>>> [ 5554.771899]
>>=20
>> No, I haven't seen this one. I'm guessing the page pointer passed to
>> kernel_sendpage was probably NULL, so this may be a case where something
>> walked off the end of the rq_pages array?
>>=20
>> Beyond that I can't tell much from just this stack trace. It might be
>> nice to see what line of code kernel_sendpage+0x60 refers to on your
>> kernel.
>=20
> Ok I reproduced it again.
>=20
> This time I updated to Chuck's 'for-next' branch at commit
> deb33fa8542eaf554e78a725cb8b922ac06978a4 (hopefully that means I'm
> 'current').
>=20
> client: 5.14.0-148 running generic/138 test.

If generic/138 does not require a scratch device, then I should have
run it many times already. I haven't seen a crash... maybe there's
something in addition that needs to happen to trigger it?


> On the network trace the last thing is a client sending a READ to the ser=
ver.
>=20
> Embarrassingly I'm unable to get the line number of kernel_sendpage.
> So I think this must be in vmlinux but when I gdb vmlinux it doesn't
> have any debugging symbols even though my configuration turns on
> debugging. I can get you the line for the svc_tcp_sendmsg+0x206 but I
> know that doesn't help. What Kconfig I need to have debug symbols for
> kernel_sendpage (I have CONFIG_DEBUG_KERNEL but I have
> CONFIG_DEBUG_INFO_NONE=3Dy so is that it should I choose something else
> here)?
>=20
> Also another piece, when I tested with a server running 5.19-rc6
> (which was based on Trond's tree for 6.0), the server didn't panic.
> Not sure if that helps.

Should be quick to bisect then.


>>> [ 5554.772249] CPU: 1 PID: 2590 Comm: nfsd Not tainted 6.0.0-rc1+ #84
>>> [ 5554.773575] Hardware name: VMware, Inc. VMware Virtual
>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>> [ 5554.775952] Call Trace:
>>> [ 5554.776500]  <TASK>
>>> [ 5554.776977]  dump_stack_lvl+0x33/0x46
>>> [ 5554.777792]  ? kernel_sendpage+0x60/0x220
>>> [ 5554.778672]  print_report.cold.12+0x499/0x6b7
>>> [ 5554.779628]  ? tcp_release_cb+0x46/0x200
>>> [ 5554.780577]  ? kernel_sendpage+0x60/0x220
>>> [ 5554.781516]  kasan_report+0xa3/0x120
>>> [ 5554.782361]  ? inet_sendmsg+0xa0/0xa0
>>> [ 5554.783217]  ? kernel_sendpage+0x60/0x220
>>> [ 5554.784191]  kernel_sendpage+0x60/0x220
>>> [ 5554.785247]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
>>> [ 5554.787188]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [sun=
rpc]
>>> [ 5554.789364]  ? refcount_dec_not_one+0xa0/0x120
>>> [ 5554.790402]  ? refcount_warn_saturate+0x120/0x120
>>> [ 5554.791495]  ? __rcu_read_unlock+0x4e/0x250
>>> [ 5554.792575]  ? __mutex_lock_slowpath+0x10/0x10
>>> [ 5554.793571]  ? tcp_release_cb+0x46/0x200
>>> [ 5554.794443]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
>>> [ 5554.796182]  ? svc_addsock+0x370/0x370 [sunrpc]
>>> [ 5554.797924]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
>>> [ 5554.799848]  ? svc_recv+0xab0/0xfa0 [sunrpc]
>>> [ 5554.801434]  svc_send+0x9c/0x260 [sunrpc]
>>> [ 5554.802963]  nfsd+0x170/0x270 [nfsd]
>>> [ 5554.804140]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
>>> [ 5554.805631]  kthread+0x160/0x190
>>> [ 5554.806354]  ? kthread_complete_and_exit+0x20/0x20
>>> [ 5554.807401]  ret_from_fork+0x1f/0x30
>>> [ 5554.808206]  </TASK>
>>> [ 5554.808699] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [ 5554.810486] Disabling lock debugging due to kernel taint
>>> [ 5554.811772] BUG: kernel NULL pointer dereference, address: 000000000=
0000008
>>> [ 5554.813236] #PF: supervisor read access in kernel mode
>>> [ 5554.814345] #PF: error_code(0x0000) - not-present page
>>> [ 5554.815462] PGD 0 P4D 0
>>> [ 5554.816032] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
>>> [ 5554.817057] CPU: 1 PID: 2590 Comm: nfsd Tainted: G    B
>>> 6.0.0-rc1+ #84
>>> [ 5554.818677] Hardware name: VMware, Inc. VMware Virtual
>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>> [ 5554.821028] RIP: 0010:kernel_sendpage+0x60/0x220
>>> [ 5554.822138] Code: 24 a0 00 00 00 e8 a0 98 83 ff 49 83 bc 24 a0 00
>>> 00 00 00 0f 84 9f 00 00 00 48 8d 43 08 48 89 c7 48 89 44 24 08 e8 80
>>> 98 83 ff <4c> 8b 63 08 41 f6 c4 01 0f 85 ee 00 00 00 0f 1f 44 00 00 48
>>> 89 df
>>> [ 5554.826047] RSP: 0018:ffff888017ef7c38 EFLAGS: 00010296
>>> [ 5554.827192] RAX: 0000000000000001 RBX: 0000000000000000 RCX: fffffff=
fa3b173b6
>>> [ 5554.828715] RDX: 0000000000000001 RSI: 0000000000000008 RDI: fffffff=
fa6b16260
>>> [ 5554.830237] RBP: ffff8880057ac380 R08: fffffbfff4d62c4d R09: fffffbf=
ff4d62c4d
>>> [ 5554.831757] R10: ffffffffa6b16267 R11: fffffbfff4d62c4c R12: fffffff=
fa545e6a0
>>> [ 5554.833341] R13: ffff8880057ac3a0 R14: 0000000000001000 R15: 0000000=
000000000
>>> [ 5554.834881] FS:  0000000000000000(0000) GS:ffff888057c80000(0000)
>>> knlGS:0000000000000000
>>> [ 5554.836590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [ 5554.837819] CR2: 0000000000000008 CR3: 000000000677e004 CR4: 0000000=
0001706e0
>>> [ 5554.839374] Call Trace:
>>> [ 5554.839919]  <TASK>
>>> [ 5554.840400]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
>>> [ 5554.842066]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [sun=
rpc]
>>> [ 5554.844194]  ? refcount_dec_not_one+0xa0/0x120
>>> [ 5554.845239]  ? refcount_warn_saturate+0x120/0x120
>>> [ 5554.846275]  ? __rcu_read_unlock+0x4e/0x250
>>> [ 5554.847199]  ? __mutex_lock_slowpath+0x10/0x10
>>> [ 5554.848171]  ? tcp_release_cb+0x46/0x200
>>> [ 5554.849039]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
>>> [ 5554.850667]  ? svc_addsock+0x370/0x370 [sunrpc]
>>> [ 5554.852285]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
>>> [ 5554.854420]  ? svc_recv+0xab0/0xfa0 [sunrpc]
>>> [ 5554.856187]  svc_send+0x9c/0x260 [sunrpc]
>>> [ 5554.857773]  nfsd+0x170/0x270 [nfsd]
>>> [ 5554.859009]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
>>> [ 5554.860602]  kthread+0x160/0x190
>>> [ 5554.861400]  ? kthread_complete_and_exit+0x20/0x20
>>> [ 5554.862452]  ret_from_fork+0x1f/0x30
>>> [ 5554.863265]  </TASK>
>>> [ 5554.863756] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
>>> iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
>>> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
>>> nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
>>> vmw_vsock_vmci_transport vsock intel_rapl_msr intel_rapl_common
>>> snd_seq_midi snd_seq_midi_event crct10dif_pclmul crc32_pclmul
>>> vmw_balloon ghash_clmulni_intel joydev pcspkr snd_ens1371
>>> snd_ac97_codec ac97_bus snd_seq btusb btrtl btbcm btintel snd_pcm
>>> snd_timer snd_rawmidi snd_seq_device bluetooth rfkill snd ecdh_generic
>>> ecc soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc ip_tables xfs
>>> libcrc32c sr_mod cdrom sg crc32c_intel nvme serio_raw nvme_core t10_pi
>>> crc64_rocksoft crc64 vmwgfx drm_ttm_helper ttm ahci drm_kms_helper
>>> ata_generic syscopyarea sysfillrect sysimgblt fb_sys_fops vmxnet3
>>> libahci ata_piix drm libata
>>> [ 5554.880681] CR2: 0000000000000008
>>> [ 5554.881539] ---[ end trace 0000000000000000 ]---
>>=20
>> --
>> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



