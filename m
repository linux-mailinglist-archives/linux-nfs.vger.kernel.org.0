Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE7E523CF2
	for <lists+linux-nfs@lfdr.de>; Wed, 11 May 2022 20:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbiEKS7Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 May 2022 14:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbiEKS7X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 May 2022 14:59:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD47B6D39A
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 11:59:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BIHpKr024435;
        Wed, 11 May 2022 18:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pPhKLvNQencwcELNcKgZ+QgPj997DwuK+NrwagYmOHs=;
 b=zjx8mkVEVlP7aCq2kCDmIX4Ok362a9+2WdLAmYji2+X6O3+7fNROIs7hIhPmegRbEoVM
 8ufkmjx6eh7WiGO+Ugu2iczRLH6X8rlW51GIlX23dc/WaRf5BzigQooazrV+k/mjBhMc
 gQVM4tA+wfWNCcabwyeUaAcFKUxYAsO88MyTFlkAyrnH8+9TV1d3Pfh+GUNVxBVHat6W
 q+CTILY/HU62TS3EdK5UXWCDdCkGoPofxboakxKjKUijW/zuzVyW31WUAC0MNnMH6bZ4
 YAY/rl2A90DWvwp0SVv77LvsJUUQ68h/baQSUQYvdafspXBnMUIRlMLm2srnnSUyQHTR mA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsttxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 18:59:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BIpBFA019749;
        Wed, 11 May 2022 18:59:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6f4bay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 18:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kic7Ij/noVfhIwe4HKXYWoyltN07QaURVfQjHGvtkq1Fm7bz27h/gaFhto2X3MVri2SCw3MGk2k7IYaIP/LkOhBD33hQsg0Ac9tNXfiYiIlOJaO8bTx4x3s1sZJOdbh8nSIp7zCVl47ojnp/snXrBBl578zsl+MZENx1obdSKY6x3QSObMDEPNtJ/P/yASMhfExVcJKJnbqunbSYNpNFT6wAK81xm0LmvJDFPSlXrQWIZFsJPTnP8GjynuR6r+ScxlAlUdGfxWBrPT3yxhmxPao0NF4nqdZ/YYB29F/ZxFmb7L9YzQxU83mT4G7df+jLqoMxZHqKPZhteWg62FKcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPhKLvNQencwcELNcKgZ+QgPj997DwuK+NrwagYmOHs=;
 b=Fi668JC+zyoT0tHfubR1b6wKGB7xMhYjPMldeuJooYuUSFP1CiAVDQ36fXa+BcjnFaVtFogYhuijXXnux47v4lZC1YY7YqfaTbzwPTe/qHGbVuPJwOiyBdBKcl962ZgZMAS6WkORQrFE9a+5AOHtNlFxGC98Zn/uw7IhHq/DlTS2UA7Ah8R9BHgq6gpqbVwdlsz4VatDriILH8q7crEYyPG0k7bt85SKMgrQ0j9zPvOlU3umCLp4SVuEENRRsrnwfv/A+DtUkiKhXuEw2OfrqMfDkpJNBHYdQiDXiscNGbHnM0RobfwFBVgLGK52KlMdWlPmeeYEzvOiqUfiLWDn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPhKLvNQencwcELNcKgZ+QgPj997DwuK+NrwagYmOHs=;
 b=q3/o4MsHy5nyjL1/62Itm7UNrYrFmPgID94jsvuo1mN0wI+a6NZIRW/piExLytE3t0G+iAJXrNLDGizWy9XfATkdns5DYDYSRqjHnAArB9qu4PLsaLbPN9/JUDRYcjrZE73oR6wpGjBsfDdSQBNZuHBEBhb55VjCG2MAXllvLO8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4390.namprd10.prod.outlook.com (2603:10b6:610:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 18:59:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 18:59:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Topic: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Index: AQHYXyGPzdf4A6mimkmk/DpMpv4nPq0YNS4AgAGbVYCAABRRAIAABPOAgAAR1ICAABgJgIAAAIOA
Date:   Wed, 11 May 2022 18:59:15 +0000
Message-ID: <B0BCF02B-0EDB-4C40-A2B0-EC0136C2D231@oracle.com>
References: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
 <ED29F5B7-9839-4BCB-AE97-AAF776D95B28@oracle.com>
 <2BC5058C-FFEE-4741-9E51-4CC66E7F6306@oracle.com>
 <6942e1963dd3548cb9ba5d8586bd3913beb1ad45.camel@hammerspace.com>
 <342BDD54-5EF0-47BC-8691-E89148B085C1@oracle.com>
 <86cfd1a8afb0a8f68d9bba95c21f04090ebba461.camel@hammerspace.com>
 <FF3D1FC6-12FB-4FAE-B9B9-08AC85437F96@oracle.com>
In-Reply-To: <FF3D1FC6-12FB-4FAE-B9B9-08AC85437F96@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 222f186c-a989-4c80-599f-08da33805844
x-ms-traffictypediagnostic: CH2PR10MB4390:EE_
x-microsoft-antispam-prvs: <CH2PR10MB439063B47FE7C2AE18EAEE8D93C89@CH2PR10MB4390.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NplDNX0ev7Jz6hbn/V1VbITENK6o7n7/q/Wyltf69XnYSRHtjca3FRsRo+GOgc5NUGt5MWGcD/uWN/sXan9k4NYmmAUKsP7nMRNEeOIHr77qtYIibGhm/I02Y9pCdk0f17BDB52D5pZrON2NgV90YWFiZ7oVSiuDjK1AIJksZFpf2SyyTpDS8o00pPcCpEdJz7mXWmm/8XEvMS7r8ggM2rzbB8zyiVaE2hJEtxAq9paEdKKl9nqnlzjx28RaXkxKGph1k12CaX21XgZQ0X6gmABScO3PV0OavzL4SM26IEPUtfFYEWinDwrKJXxOb2DxLNBrmRPODDVydRYVEtu6mtN8bBZbnVLOrVzcuKddSxf1AQq8ZkYF6ivA/3dSEdsIp+a499oqFPJQn60JhwaMtkl3NWHX3+eR8yinNIQlGa8sEEAdAx27ge4WEfhGexHPql/4yxQaSW/+8Lezr8GD6BdfIfG8Tl0mu0DIrT0W3G+DaByEo1pZCXfVlLjbPnuxK9ReN6FbiiuRInc65rR2Fir8YixfnoZui6QHloa8CSDjMU1CnE0DVSgvSAIFkRJeYkxtkfrzkjiasu/OKjWyVnMIYaN/+fGsy2YnTaXnpdd57Sl+SdedLUayJ+MRpSczjTcBUXYp13mjw2cdkqKs+t/2+rwkL/Nswl4nv6z6iPGc4THOHB+ODFfawdyLg7nuMuaDNCGncGeCIRDgaP3bp1bNpf4TTuzkrs2aej8mu2hSNwRPp+YSTDjA+NtrrFtQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(26005)(45080400002)(30864003)(8936002)(4326008)(66556008)(66446008)(6916009)(83380400001)(66946007)(91956017)(54906003)(8676002)(64756008)(76116006)(6486002)(6512007)(71200400001)(38070700005)(38100700002)(508600001)(36756003)(122000001)(2616005)(2906002)(53546011)(6506007)(86362001)(33656002)(107886003)(186003)(5660300002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8TtdvGf5wt7YHgU039Q2lNJXXch5KuGE4fkwxZZnsN7fe1wayys4e4lV+cM0?=
 =?us-ascii?Q?gY4C1wI1KUI5/jJugLm/EaUNeYFloqe4weeRAcIDFak5I1B4Z+xwyns+kymN?=
 =?us-ascii?Q?yMQ0hqk8N901avDh2H3TCMCfDls5F5DR6V4PCIMrfmVIhIs7jn/dzv7vZ5lo?=
 =?us-ascii?Q?1BtfTQLYuAZWhJYS9qvYciMOquQgq6aXNDUu9hH05FauvRoCu5VMVu1BBKJj?=
 =?us-ascii?Q?qEpKYufJpoDt6Hb0VkPFKc9kRPM8aupM7KLkGTbvp15RZtpnxPsuuy1bOE4+?=
 =?us-ascii?Q?DlW8J58Dw7RSgluBBeLVXYu0sY43jqwhyvuRxtoIM70RcdBKG1OqyGn0xga2?=
 =?us-ascii?Q?+JTKzGyFwcAETbbDgAuJlzxf1gYQ3RyRmJ7rDhb1S8YKGQdE9r08A+3oqA28?=
 =?us-ascii?Q?qOybfrPlUuk394dMX5Z9rtjulnoMUZ161Yo21qytWQwsbZARgz2UVf10uuWc?=
 =?us-ascii?Q?+qy6731LM7T3KJrvPyLLt00p6eNo6IXjBv/7AC0N2wBEBh9fWsms1SAsMU/s?=
 =?us-ascii?Q?6tQ+TxyPap/S6ZxYBFuclhYLcF+qwl9o1n+oE24GMCNjWSsxZoyPugBE+GJC?=
 =?us-ascii?Q?W5eo+FIcT3uVh30nc7ADaifhoc4E/sVBBkGzoxN8ejJ7fLj7/obe2QCUjdY4?=
 =?us-ascii?Q?vFofLLNJM4Cpm3E2BX/7sEuagwf9AhLDvUD/HAqjm3TvRPILMFAq6YFVunNo?=
 =?us-ascii?Q?OceuYNBrUbkesxNKF2/sKCaBwv8W0wDWCPH0Yc+MBzBcrda16ZOlb/8HUsyG?=
 =?us-ascii?Q?RLko71U3dWNBG3ZY2Kq5xX3tHzEdLEMHCfEc9314NWrl7YWRyUASoW0aoA77?=
 =?us-ascii?Q?yKcZz2tsw1oVdeI2SHmfAXJNE/7jyMqc5KqkR9VFVzZ6a9iJfYF97TnecfsX?=
 =?us-ascii?Q?s7EsJlEdU0CxhbqSc6xOdAfvsgJhhlQpjMW7GvNkdrqEeQ3+ws6tdd8rj6TK?=
 =?us-ascii?Q?DH8KLrJrRhQJv8D+ZqP/5GfQ6HCJ+JhgW+vEvq3bshRfareB1cndGeX78JwH?=
 =?us-ascii?Q?htyMh4Rfc28RRHKViZIN7Bl+fztESZx1zdcUIlRfZKxu9te0WXBTm4iMIwdz?=
 =?us-ascii?Q?L/ENDaixq0nIdvrJa2mHaLWNxojWwdiR+FGlM5PionYJcXFU2n6MExwHiuP7?=
 =?us-ascii?Q?0a4hD0CbyTK5NYVtqLkHhnmd7hbuNspLZpqZ3x/VlYqMQFhIvUMMhLYAuZcV?=
 =?us-ascii?Q?/02FD0DXzQjghMgeDm5fOgfo9aWLdEVETJmkcx5SVGPL4uFWd3MYGIfrZND7?=
 =?us-ascii?Q?XRZpfRpTnOJLlfJsslDL0fvcz04QlnMpC3kVOzovS58to2i+56bb7Cs20qe8?=
 =?us-ascii?Q?V4MH6kX8j+/NQy3kWMtnOrtSBRrmrPe2auaXmPmpf8n0uFGiS69x3T0FDMkS?=
 =?us-ascii?Q?ECqfs0aLuZr6EvnR5IppjPHCTUFSLs+1ZAwUTbUNGODrZre5Txqc6Rv+rMuw?=
 =?us-ascii?Q?TNMiGv8RCWOQhdSvhnnjGFJIN7nprJajS9uYriJaQAm+qJDaN/DpRqQuBFXE?=
 =?us-ascii?Q?xKkrruB03HyrRcZsyFMzvPAeXG6xYDJpbadLlnI7T863bf8HL4wt9NXyzwM1?=
 =?us-ascii?Q?7IRe0eKFdc0yfuHxLx8v6ezp8SrqaKH/nVhQ3O/3gF/2LFpPrS0Ift2M/76C?=
 =?us-ascii?Q?WtvbfR+KPR1J8sFA5NPnHv6fPW+NPZpLPbbLx++YRCHpUwv+bA7Dvw0WmWXD?=
 =?us-ascii?Q?WpO695FC5Ag1q1dMCC9GzOE/+bZkd/CF7t2fS/N8jfYefJCMW+WiajN5FR79?=
 =?us-ascii?Q?By7gNpipZtad5eA+lwuavAhfnG6A12A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B58D4766EB7DE144AE35F6D015A7E88B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222f186c-a989-4c80-599f-08da33805844
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 18:59:15.5738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xi9+8LH/gFDksSDly0BJnRmAI/x+duHLhkf9dI+CCwrIHDxsothBDDOH8zyqcg0+OL73z7L4A6lxsWPuUXmqFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4390
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110082
X-Proofpoint-GUID: QHFt94DXNbQcjOHqoKoC3FcxEwHdVxTY
X-Proofpoint-ORIG-GUID: QHFt94DXNbQcjOHqoKoC3FcxEwHdVxTY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 11, 2022, at 2:57 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On May 11, 2022, at 1:31 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>>=20
>> On Wed, 2022-05-11 at 16:27 +0000, Chuck Lever III wrote:
>>>=20
>>>=20
>>>> On May 11, 2022, at 12:09 PM, Trond Myklebust
>>>> <trondmy@hammerspace.com> wrote:
>>>>=20
>>>> On Wed, 2022-05-11 at 14:57 +0000, Chuck Lever III wrote:
>>>>>=20
>>>>>=20
>>>>>> On May 10, 2022, at 10:24 AM, Chuck Lever III
>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On May 3, 2022, at 3:11 PM, dai.ngo@oracle.com wrote:
>>>>>>>=20
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> I just noticed there were couple of oops in my Oracle6 in
>>>>>>> nfs4.dev network.
>>>>>>> I'm not sure who ran which tests (be useful to know) that
>>>>>>> caused
>>>>>>> these oops.
>>>>>>>=20
>>>>>>> Here is the stack traces:
>>>>>>>=20
>>>>>>> [286123.154006] BUG: sleeping function called from invalid
>>>>>>> context at kernel/locking/rwsem.c:1585
>>>>>>> [286123.155126] in_atomic(): 1, irqs_disabled(): 0,
>>>>>>> non_block: 0,
>>>>>>> pid: 3983, name: nfsd
>>>>>>> [286123.155872] preempt_count: 1, expected: 0
>>>>>>> [286123.156443] RCU nest depth: 0, expected: 0
>>>>>>> [286123.156771] 1 lock held by nfsd/3983:
>>>>>>> [286123.156786]  #0: ffff888006762520 (&clp->cl_lock){+.+.}-
>>>>>>> {2:2}, at: nfsd4_release_lockowner+0x306/0x850 [nfsd]
>>>>>>> [286123.156949] Preemption disabled at:
>>>>>>> [286123.156961] [<0000000000000000>] 0x0
>>>>>>> [286123.157520] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Not
>>>>>>> tainted 5.18.0-rc4+ #1
>>>>>>> [286123.157539] Hardware name: innotek GmbH
>>>>>>> VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>>>>>> [286123.157552] Call Trace:
>>>>>>> [286123.157565]  <TASK>
>>>>>>> [286123.157581]  dump_stack_lvl+0x57/0x7d
>>>>>>> [286123.157609]  __might_resched.cold+0x222/0x26b
>>>>>>> [286123.157644]  down_read_nested+0x68/0x420
>>>>>>> [286123.157671]  ? down_write_nested+0x130/0x130
>>>>>>> [286123.157686]  ? rwlock_bug.part.0+0x90/0x90
>>>>>>> [286123.157705]  ? rcu_read_lock_sched_held+0x81/0xb0
>>>>>>> [286123.157749]  xfs_file_fsync+0x3b9/0x820
>>>>>>> [286123.157776]  ? lock_downgrade+0x680/0x680
>>>>>>> [286123.157798]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>>>>>>> [286123.157823]  ? nfsd_file_put+0x100/0x100 [nfsd]
>>>>>>> [286123.157921]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>>>>> [286123.158007]  nfsd_file_put+0x79/0x100 [nfsd]
>>>>>>> [286123.158088]  check_for_locks+0x152/0x200 [nfsd]
>>>>>>> [286123.158191]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>>>>>>> [286123.158393]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>>>>>>> [286123.158488]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.158525]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>>>>>>> [286123.158699]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>>>>>>> [286123.158974]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.159010]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>>>>>>> [286123.159043]  ? svc_generic_rpcbind_set+0x450/0x450
>>>>>>> [sunrpc]
>>>>>>> [286123.159043]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>>>>>>> [286123.159043]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>>>>>>> [286123.159043]  ? svc_recv+0x1100/0x2390 [sunrpc]
>>>>>>> [286123.159043]  svc_process+0x361/0x4f0 [sunrpc]
>>>>>>> [286123.159043]  nfsd+0x2d6/0x570 [nfsd]
>>>>>>> [286123.159043]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>>>>>>> [286123.159043]  kthread+0x29f/0x340
>>>>>>> [286123.159043]  ? kthread_complete_and_exit+0x20/0x20
>>>>>>> [286123.159043]  ret_from_fork+0x22/0x30
>>>>>>> [286123.159043]  </TASK>
>>>>>>> [286123.187052] BUG: scheduling while atomic:
>>>>>>> nfsd/3983/0x00000002
>>>>>>> [286123.187551] INFO: lockdep is turned off.
>>>>>>> [286123.187918] Modules linked in: nfsd auth_rpcgss nfs_acl
>>>>>>> lockd
>>>>>>> grace sunrpc
>>>>>>> [286123.188527] Preemption disabled at:
>>>>>>> [286123.188535] [<0000000000000000>] 0x0
>>>>>>> [286123.189255] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded
>>>>>>> Tainted: G        W         5.18.0-rc4+ #1
>>>>>>> [286123.190233] Hardware name: innotek GmbH
>>>>>>> VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>>>>>> [286123.190910] Call Trace:
>>>>>>> [286123.190910]  <TASK>
>>>>>>> [286123.190910]  dump_stack_lvl+0x57/0x7d
>>>>>>> [286123.190910]  __schedule_bug.cold+0x133/0x143
>>>>>>> [286123.190910]  __schedule+0x16c9/0x20a0
>>>>>>> [286123.190910]  ? schedule_timeout+0x314/0x510
>>>>>>> [286123.190910]  ? __sched_text_start+0x8/0x8
>>>>>>> [286123.190910]  ? internal_add_timer+0xa4/0xe0
>>>>>>> [286123.190910]  schedule+0xd7/0x1f0
>>>>>>> [286123.190910]  schedule_timeout+0x319/0x510
>>>>>>> [286123.190910]  ? rcu_read_lock_held_common+0xe/0xa0
>>>>>>> [286123.190910]  ? usleep_range_state+0x150/0x150
>>>>>>> [286123.190910]  ? lock_acquire+0x331/0x490
>>>>>>> [286123.190910]  ? init_timer_on_stack_key+0x50/0x50
>>>>>>> [286123.190910]  ? do_raw_spin_lock+0x116/0x260
>>>>>>> [286123.190910]  ? rwlock_bug.part.0+0x90/0x90
>>>>>>> [286123.190910]  io_schedule_timeout+0x26/0x80
>>>>>>> [286123.190910]  wait_for_completion_io_timeout+0x16a/0x340
>>>>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.190910]  ? wait_for_completion+0x330/0x330
>>>>>>> [286123.190910]  submit_bio_wait+0x135/0x1d0
>>>>>>> [286123.190910]  ? submit_bio_wait_endio+0x40/0x40
>>>>>>> [286123.190910]  ? xfs_iunlock+0xd5/0x300
>>>>>>> [286123.190910]  ? bio_init+0x295/0x470
>>>>>>> [286123.190910]  blkdev_issue_flush+0x69/0x80
>>>>>>> [286123.190910]  ? blk_unregister_queue+0x1e0/0x1e0
>>>>>>> [286123.190910]  ? bio_kmalloc+0x90/0x90
>>>>>>> [286123.190910]  ? xfs_iunlock+0x1b4/0x300
>>>>>>> [286123.190910]  xfs_file_fsync+0x354/0x820
>>>>>>> [286123.190910]  ? lock_downgrade+0x680/0x680
>>>>>>> [286123.190910]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>>>>>>> [286123.190910]  ? nfsd_file_put+0x100/0x100 [nfsd]
>>>>>>> [286123.190910]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>>>>> [286123.190910]  nfsd_file_put+0x79/0x100 [nfsd]
>>>>>>> [286123.190910]  check_for_locks+0x152/0x200 [nfsd]
>>>>>>> [286123.190910]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>>>>>>> [286123.190910]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>>>>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.190910]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>>>>>>> [286123.190910]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>>>>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>>> [286123.190910]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>>>>>>> [286123.190910]  ? svc_generic_rpcbind_set+0x450/0x450
>>>>>>> [sunrpc]
>>>>>>> [286123.190910]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>>>>>>> [286123.190910]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>>>>>>> [286123.190910]  ? svc_recv+0x1100/0x2390 [sunrpc]
>>>>>>> [286123.190910]  svc_process+0x361/0x4f0 [sunrpc]
>>>>>>> [286123.190910]  nfsd+0x2d6/0x570 [nfsd]
>>>>>>> [286123.190910]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>>>>>>> [286123.190910]  kthread+0x29f/0x340
>>>>>>> [286123.190910]  ? kthread_complete_and_exit+0x20/0x20
>>>>>>> [286123.190910]  ret_from_fork+0x22/0x30
>>>>>>> [286123.190910]  </TASK>
>>>>>>>=20
>>>>>>> The problem is the process tries to sleep while holding the
>>>>>>> cl_lock by nfsd4_release_lockowner. I think the problem was
>>>>>>> introduced with the filemap_flush in nfsd_file_put since
>>>>>>> 'b6669305d35a nfsd: Reduce the number of calls to
>>>>>>> nfsd_file_gc()'.
>>>>>>> The filemap_flush is later replaced by nfsd_file_flush by
>>>>>>> '6b8a94332ee4f nfsd: Fix a write performance regression'.
>>>>>>=20
>>>>>> That seems plausible, given the traces above.
>>>>>>=20
>>>>>> But it begs the question: why was a vfs_fsync() needed by
>>>>>> RELEASE_LOCKOWNER in this case? I've tried to reproduce the
>>>>>> problem, and even added a might_sleep() call in
>>>>>> nfsd_file_flush()
>>>>>> but haven't been able to reproduce.
>>>>>=20
>>>>> Trond, I'm assuming you switched to a synchronous flush here to
>>>>> capture writeback errors. There's no other requirement for
>>>>> waiting for the flush to complete, right?
>>>>=20
>>>> It's because the file is unhashed, so it is about to be closed and
>>>> garbage collected as soon as the refcount goes to zero.
>>>>=20
>>>>>=20
>>>>> To enable nfsd_file_put() to be invoked in atomic contexts again,
>>>>> would the following be a reasonable short term fix:
>>>>>=20
>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>>> index 2c1b027774d4..96c8d07788f4 100644
>>>>> --- a/fs/nfsd/filecache.c
>>>>> +++ b/fs/nfsd/filecache.c
>>>>> @@ -304,7 +304,7 @@ nfsd_file_put(struct nfsd_file *nf)
>>>>> {
>>>>>        set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>>>>        if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
>>>>> -               nfsd_file_flush(nf);
>>>>> +               filemap_flush(nf->nf_file->f_mapping);
>>>>>                nfsd_file_put_noref(nf);
>>>>>        } else {
>>>>>                nfsd_file_put_noref(nf);
>>>>>=20
>>>>>=20
>>>>=20
>>>> filemap_flush() sleeps, and so does nfsd_file_put_noref() (it can
>>>> call
>>>> filp_close() + fput()), so this kind of change isn't going to work
>>>> no
>>>> matter how you massage it.
>>>=20
>>> Er. Wouldn't that mean we would have seen "sleep while spinlock is
>>> held" BUGs since nfsd4_release_lockowner() was added? It's done
>>> at least an fput() while holding clp->cl_lock since it was added,
>>> I think.
>>=20
>>=20
>> There is nothing magical about using WB_SYNC_NONE as far as the
>> writeback code is concerned. write_cache_pages() will still happily
>> call lock_page() and sleep on that lock if it is contended. The
>> writepage/writepages code will happily try to allocate memory if
>> necessary.
>>=20
>> The only difference is that it won't sleep waiting for the PG_writeback
>> bit.
>>=20
>> So, no, you can't safely call filemap_flush() from a spin locked
>> context, and
>> yes, the bug has been there from day 1. It was not introduced by me.
>>=20
>> Also, as I said, nfsd_file_put_noref() is not safe to call from a spin
>> locked context. Again, this was not introduced any time recently.
>=20
> OK. I'm trying to figure out how bad the problem is and how
> far back to apply the fix.
>=20
> I agree that the arrangement of the code path means
> nfsd4_release_lockowner() has always called fput() or
> filemap_flush() while cl_lock was held.
>=20
> But again, I'm not aware of recent instances of this particular
> splat. So I'm wondering if a recent change has made this issue
> easier to hit. We might not be able to answer that until we
> find out how the bake-a-thon testers managed to trigger the
> issue on Dai's server.
>=20
>=20
>>>> Is there any reason why you need a reference to the nfs_file there?
>>>> Wouldn't holding the fp->fi_lock be sufficient, since you're
>>>> already in
>>>> an atomic context? As long as one of the entries in fp->fi_fds[] is
>>>> non-zero then you should be safe.
>>>=20
>>> Sure, check_for_locks() seems to be the only problematic caller.
>>> Other callers appear to be careful to call nfsd_file_put() only
>>> after releasing spinlocks.
>>>=20
>>> I would like a fix that can be backported without fuss. I was
>>> thinking changing check_for_locks() might get a little too
>>> hairy for that, but I'll check it out.
>=20
> Notably: check_for_locks() needs to drop fi_lock before taking
> flc_lock because the OPEN path can take flc_lock first, then

Bzzt. Not OPEN, but rather nfsd_file_acquire().


> fi_lock, via nfsd_break_deleg_cb(). Holding a reference to the
> nfsd_file guarantees that the inode won't go away while
> check_for_locks() examines the flc_posix list without holding
> fi_lock.
>=20
> So my first take on this was we need nfsd4_release_lockowner()
> to drop cl_lock before check_for_locks() is called.
>=20
>=20
> --
> Chuck Lever

--
Chuck Lever



