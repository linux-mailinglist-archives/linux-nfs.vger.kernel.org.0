Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274505A6C78
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 20:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiH3Slo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiH3Slm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 14:41:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4CD3C178
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 11:41:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UHtlQM000534;
        Tue, 30 Aug 2022 18:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dhO/6RD72mms9iNUmuvmzoPjMmi2QgOF/hmErZWuvR0=;
 b=UxnRbeIM0tfQgBOf000j6WdepQtlN2/UxcRcTrHUGxKCXTRZYWKDAsyLVSGqzXFLUmxZ
 M9NXfNpP/fEsJedo9OTCANKdewKphyAp5P/7Xpx2WD1LDTWhEmvpgUDUfW7KwCS11Ntn
 eo01PMGafD9f3Q6OCBUd0Y6fW/06hoFWuTS4aF8rz2FZo6bi6s0FsK1DN3uMxfmUYyP9
 9wkmxic+RJ92SumHV9Utd8anNYCxgh7Ts2PK3CzSFTyirof1zqtSPj2Hotcw1oExFRyY
 1g7EB4qwJZAbSdjr09CzXyX0NZj7zeO84mXGcXz6w04Sd8K3L674Wq9nNR6HYi+6PJJ/ Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt77pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:41:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIXVgc013084;
        Tue, 30 Aug 2022 18:41:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q49g0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:41:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN9sgaT9We1AxxSHdD3G+Fa6vsE3lb2t293EFE5A0mDTeV3M2pe8ni0D88Mzae9DoyymX7xqi2q+HAQknk4+TL+HN4+Vqa5PbfhUuWGzURjJiAFnmElTzO6Poh92HTfqtSV5O9nyJUqY2KntHkKAkGZGHOEix7Q+t7P/HANgTq80ifwo+jQ+IUvZlIDE4g66gJrhdiRsch7aMU0f2qDKdAZhqai9HvIkSrVmqGKuGHIK3LRhNmFe76FIrzArVwCfWSWfuAtZcDl77xeQtKsbbFYaBJK5TeqCQr6tqK60FZZ5BAZeLbMcjIJmUCFj2USg1ZvYktOcMJ7atEeO1/vf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhO/6RD72mms9iNUmuvmzoPjMmi2QgOF/hmErZWuvR0=;
 b=LY/QoVCY+TEp6P9cIMuPzM0XnPbZ1Ztv+ZbMK/dCWV2BdBJPBk/beIDZ52sgUSF5V4J+gpHQ7/rT4P2+VwvFEPmJ3Mus6dioHQ1pFBs41MAheACNjp8TWIOpTL1guLMCRRgV/TlE+W52kI0gqWGT9NlBYKNXLQtcgXft/kfMDZID3q+GaAR+UBeig55wgVLF9U+r/ysTnUGeBE9rbFcN6+ME7Qv4AwQktL+Uy+eZcnlZQZyTXfJVuVqQRRzhafVQfhSYsdtSQJBLeLiutwVExzWqy4rZeESOqKWarJuleQ9QeQ8x85YCcFua0ysrk/dZ7dnAQ9LK4kRdtAK1TU8yWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhO/6RD72mms9iNUmuvmzoPjMmi2QgOF/hmErZWuvR0=;
 b=s6F+KuTrBrAfJlOutuCWS/IiNeN08wAQ/979a/uj/QY+y9+wIqo/UOwt8ZKrJwu8PTCQ6NJ04rJ+SyX9Mncci+BPscfyJAEee639JaIy2jFh/W8lnj+/1jM2O2Y/PQ7OTeEZRKYB4UVCfp8KUMSqchKreHALxxHic1N1O5Iv7x4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5657.namprd10.prod.outlook.com (2603:10b6:510:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 18:41:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 18:41:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Thread-Topic: Is this nfsd kernel oops known?
Thread-Index: AQHYvJP9R6JamLcYaUyLf/owehh7vq3HuG2AgAAJRICAAAEjgIAAAgQAgAACOYA=
Date:   Tue, 30 Aug 2022 18:41:27 +0000
Message-ID: <07430062-E2A2-4EF1-A016-E3A5E895959B@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyGqK1NsWP42+ZX-wpBrd=u2g9mQB8PZiRQqWTvp-B+6qQ@mail.gmail.com>
 <74A58EE9-DA83-4C17-B270-110EA11844E4@oracle.com>
 <CAN-5tyFgZ5bCjmfgDBtShUrRWsBk-1m41ndppcx8BYDxD8ECZg@mail.gmail.com>
In-Reply-To: <CAN-5tyFgZ5bCjmfgDBtShUrRWsBk-1m41ndppcx8BYDxD8ECZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22343be7-8326-4956-3aa9-08da8ab73f93
x-ms-traffictypediagnostic: PH0PR10MB5657:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHyrtYcnPu7Be7eYAKVBeahDE2X9OpFPBS6aq0D+WxnVkJQZJBc3I1g6NpmcgckzyF/NqhMtQCmL6y9oCjqpT3ClVkgMohI9h9DpwKjPs7PgBpf4sIbjkWN2lPrLzigPPz+IXth5+PhQRrCEnfYuHPTOoeHZ9J5bw5jdVCF5XGqcTpcU+TeHjo/nzI7uREP0AWWQB3FvoKZV6/ADYRFw4SDIry5oz1z+aAcjWbfEWegkbC6mBCzLWfaH0bALsxPYP6AHE+KHg0n1sN2WDxNTeJwY1VJKMjaKL6a5d/GsaCpBpM7eri6DWBmJ5JsTLwXf5oOEHIaRqh4MBn9zBzIj/MqPWr4k2Kdv7+2gYcAHjzdtuwezxWk5olheTbyxAw80lUX8uQA1QBXbim9lIlbO7tw6wPT9fC6QXJIKmbxonvLhd8eyeCsB5XpnY6aNwI9pgHWawxqg1eqf3ocrx9YZi80/0+Sf6uS/HQUZ7IQJGkHBl+sx5RIIZqPOmouEH52JaL9Zr32awOZNbLCnYNU30NZMHg0dayvbRb0GU5w6raj0ELj6hCMWf2BpB9WwPEsqnxAIiOT3Ij4Zie8ZegH+acfZjITyis1ibtaHwmovbaA9qHod771QPysHntUrG/0YqBfFeYvXWRYSvBmvhoiVERXSj+a64U56L/YLw4bnOP80v93f1XDUBK4D5vEhvkqFqWHsKSbb7mlgftDGu/srW6+R0WVWfbnhOI2JEnXgu6t5K9xGq3oFBcLdgZWCGYkAnxm5RbaYd8Lv2Jmt8XlV9gKc3MhO4IuK1/HquMIjhO4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(346002)(39860400002)(6916009)(8676002)(64756008)(316002)(76116006)(54906003)(45080400002)(4326008)(66446008)(91956017)(66476007)(2906002)(8936002)(5660300002)(66556008)(38100700002)(66946007)(122000001)(33656002)(36756003)(53546011)(86362001)(71200400001)(6512007)(6506007)(26005)(6486002)(478600001)(38070700005)(41300700001)(186003)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dQWQGMIzrLeWW0MxBLUSTbul2Y8L+9EUNS2E2AvCqV1ZV1340kK6vIXhhfMc?=
 =?us-ascii?Q?YBYCkm0wDiykIFcA7Km8asDnJS+0ds0KzbPN/tvy9a9xNaCMlAqMF9De/br2?=
 =?us-ascii?Q?+Myl8bj/+v4mv4HpnbpNRZ0zsObYwe+xyVwyzn85YwufTrCdX7p+oZSfex6e?=
 =?us-ascii?Q?AcF79u0XvfE/bpIuYwPK3aKl3Hdy0WQw4veljOmyfW9YYnCH264LXMSluJgq?=
 =?us-ascii?Q?+SJ3OXfZl0tYbkKURwea1uFwd/x9nU4JcdArK8PiJhaA4HdC7AMwQMUZgZed?=
 =?us-ascii?Q?tnSJOFzKP1Aj4JPbVoAueCbgxXqpeQ6QKzsJ8tQpYgBE65xLQwbrG3mkzNEl?=
 =?us-ascii?Q?XGliZ9yDs53tkJn2MggkGp0PpddWTx2nu5CBDJQGdfpE0Zr8JtsF/DYwJ3Fs?=
 =?us-ascii?Q?mHbCgR8mUYXIur4TvlPK2b0Ao0TxcoC5xo6pClv0OE7ANlk3z+OauysVk4vz?=
 =?us-ascii?Q?yGgvXu9CMDYd24/9V2qN2eIiu4z2mz6b9qyIuARo0cTpOPT5z2tMg12p3iI/?=
 =?us-ascii?Q?ZRgRpEyNVZVjuw7NVnv2BhBLCssLJJ1FOH6u/oKQ72kRkIfTtI9x/u5mecE0?=
 =?us-ascii?Q?S6VSaxLIvWa4kuSaYHjYfQB973VX/mo6V9amvjspOMrgbnl4pdmucDfkvq77?=
 =?us-ascii?Q?P7sVnTEUa4pTaJ8LI3O59O0oqGp9JlL+phhd4h0V4vmSPuzHF50GyoS6l/jB?=
 =?us-ascii?Q?bobAdzFmIse7Og9HvoMZyolZwzIHpTY8FmRpt3vUw9yGMq01rOD9YX6xmmPF?=
 =?us-ascii?Q?XtEaUCscD5SkXWriM2epORhFW81QlCEfI8IPx4mYXq0uSFPEFs3QcTeq/4vN?=
 =?us-ascii?Q?8TplQCcH5NV69bHm7HkGFtAr5oQcoSqaa2xx7MJHbVQN0BuYNXXu8EsHhnoh?=
 =?us-ascii?Q?pQbnP0Q/y2PimCR91mhiuAZgVIcGSbm/dUlhNNoosiBNdLMl94qSASbvLJs+?=
 =?us-ascii?Q?dFbVP/E8E8qjAAaFzLeWkV5MVSHKVuhvqmwNCN3J6WoUuaY5YRcEPpd2K2hf?=
 =?us-ascii?Q?GmmoIaQI6Km2t9DmXsMm5dD7KhriJKPukIKSHSKxQRCsS+VSyN7ZBk6CO3dP?=
 =?us-ascii?Q?0A9OIhAihmZ41RHOCUWXy5mU+0L9UBtGbV3wSB9laZxqVi08SxzX6H5luVGY?=
 =?us-ascii?Q?GEJQd9ZkcEqEJaetoERLkVf6C3USgDWCmH+A0iIW23yLTDESLdzWc1Gvg0DZ?=
 =?us-ascii?Q?osk+68iVHJA6Kn1MtHH0C72IJYVZPGXSmRyL6a+Lsn5C83W6T5R7oknUbcwB?=
 =?us-ascii?Q?cPKa8huLHCLRMM0kckIOQ9G0FQzCccOwUi8lY3dY3rGPYe2WctZgpGyQVaDS?=
 =?us-ascii?Q?5yxzOqeLeyH7QpwgpIwOE9pHbG4V7XjvXlY5pdqqMTRQmQyXBdWM8R33CESx?=
 =?us-ascii?Q?fJwJC2Zyrv5oBaqKys3Fub8HK9l3ZII5kGso4e70mRIVVG5WJwREo8e5hfeM?=
 =?us-ascii?Q?OaiGwqpvGOY87kFAOCR35+WVvM0N6mEcNFXfrv7+xnOIFj7BjH1PxZyIHIFI?=
 =?us-ascii?Q?RwJGKSV0Nul8TOMlUUu0AwJRYa83QB6iEOk5YnBLeojZUgzeXtFgtn7x7wcV?=
 =?us-ascii?Q?pClPP3e/gl4UkL/AF860/wyxOU9UKpx4Pt2F3qN4yoLQLPQCS7jkWKhh9cbq?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F85B594946A3DE49B307C5A783FF0E57@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22343be7-8326-4956-3aa9-08da8ab73f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 18:41:27.6451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CkWYOQW60mLmb8buDNMDC+6HCLhNCY7WbINJ1hvWlgUzDGS3NS3gI+aW1A5T7K0onTBLBmwmuqew6lWCDUCpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300084
X-Proofpoint-ORIG-GUID: z8PEaeZ1ZPg-AL0XdVZs-daShGWNFLyF
X-Proofpoint-GUID: z8PEaeZ1ZPg-AL0XdVZs-daShGWNFLyF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 30, 2022, at 2:33 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Aug 30, 2022 at 2:26 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>> On Aug 30, 2022, at 2:22 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>=20
>>> On Tue, Aug 30, 2022 at 1:49 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> On Tue, 2022-08-30 at 13:14 -0400, Olga Kornievskaia wrote:
>>>>> Hi folks,
>>>>>=20
>>>>> Is this a known nfsd kernel oops in 6.0-rc1. Was running xfstests on
>>>>> pre-rhel-9.1 client against 6.0-rc1 server when it panic-ed.
>>>>>=20
>>>>> [ 5554.769159] BUG: KASAN: null-ptr-deref in kernel_sendpage+0x60/0x2=
20
>>>>> [ 5554.770526] Read of size 8 at addr 0000000000000008 by task nfsd/2=
590
>>>>> [ 5554.771899]
>>>>=20
>>>> No, I haven't seen this one. I'm guessing the page pointer passed to
>>>> kernel_sendpage was probably NULL, so this may be a case where somethi=
ng
>>>> walked off the end of the rq_pages array?
>>>>=20
>>>> Beyond that I can't tell much from just this stack trace. It might be
>>>> nice to see what line of code kernel_sendpage+0x60 refers to on your
>>>> kernel.
>>>=20
>>> Ok I reproduced it again.
>>>=20
>>> This time I updated to Chuck's 'for-next' branch at commit
>>> deb33fa8542eaf554e78a725cb8b922ac06978a4 (hopefully that means I'm
>>> 'current').
>>>=20
>>> client: 5.14.0-148 running generic/138 test.
>>=20
>> If generic/138 does not require a scratch device, then I should have
>> run it many times already. I haven't seen a crash... maybe there's
>> something in addition that needs to happen to trigger it?
>=20
> Looking at the test generic/138 is one of the tests that's going
> against /scratch so I'm assuming it's using a scratch device.

Can you tell if it's the server under test that crashes, or is
it the server hosting the scratch device?


>>> On the network trace the last thing is a client sending a READ to the s=
erver.
>>>=20
>>> Embarrassingly I'm unable to get the line number of kernel_sendpage.
>>> So I think this must be in vmlinux but when I gdb vmlinux it doesn't
>>> have any debugging symbols even though my configuration turns on
>>> debugging. I can get you the line for the svc_tcp_sendmsg+0x206 but I
>>> know that doesn't help. What Kconfig I need to have debug symbols for
>>> kernel_sendpage (I have CONFIG_DEBUG_KERNEL but I have
>>> CONFIG_DEBUG_INFO_NONE=3Dy so is that it should I choose something else
>>> here)?
>>>=20
>>> Also another piece, when I tested with a server running 5.19-rc6
>>> (which was based on Trond's tree for 6.0), the server didn't panic.
>>> Not sure if that helps.
>>=20
>> Should be quick to bisect then.
>=20
> Um..  I disagree but let's agree to disagree.

OK, let me rephrase... Would you please bisect this? I'm at a loss
to think of a commit in 6.0-rc that would change behavior with TCP
transports.


>>>>> [ 5554.772249] CPU: 1 PID: 2590 Comm: nfsd Not tainted 6.0.0-rc1+ #84
>>>>> [ 5554.773575] Hardware name: VMware, Inc. VMware Virtual
>>>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>>>> [ 5554.775952] Call Trace:
>>>>> [ 5554.776500]  <TASK>
>>>>> [ 5554.776977]  dump_stack_lvl+0x33/0x46
>>>>> [ 5554.777792]  ? kernel_sendpage+0x60/0x220
>>>>> [ 5554.778672]  print_report.cold.12+0x499/0x6b7
>>>>> [ 5554.779628]  ? tcp_release_cb+0x46/0x200
>>>>> [ 5554.780577]  ? kernel_sendpage+0x60/0x220
>>>>> [ 5554.781516]  kasan_report+0xa3/0x120
>>>>> [ 5554.782361]  ? inet_sendmsg+0xa0/0xa0
>>>>> [ 5554.783217]  ? kernel_sendpage+0x60/0x220
>>>>> [ 5554.784191]  kernel_sendpage+0x60/0x220
>>>>> [ 5554.785247]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
>>>>> [ 5554.787188]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [s=
unrpc]
>>>>> [ 5554.789364]  ? refcount_dec_not_one+0xa0/0x120
>>>>> [ 5554.790402]  ? refcount_warn_saturate+0x120/0x120
>>>>> [ 5554.791495]  ? __rcu_read_unlock+0x4e/0x250
>>>>> [ 5554.792575]  ? __mutex_lock_slowpath+0x10/0x10
>>>>> [ 5554.793571]  ? tcp_release_cb+0x46/0x200
>>>>> [ 5554.794443]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
>>>>> [ 5554.796182]  ? svc_addsock+0x370/0x370 [sunrpc]
>>>>> [ 5554.797924]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
>>>>> [ 5554.799848]  ? svc_recv+0xab0/0xfa0 [sunrpc]
>>>>> [ 5554.801434]  svc_send+0x9c/0x260 [sunrpc]
>>>>> [ 5554.802963]  nfsd+0x170/0x270 [nfsd]
>>>>> [ 5554.804140]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
>>>>> [ 5554.805631]  kthread+0x160/0x190
>>>>> [ 5554.806354]  ? kthread_complete_and_exit+0x20/0x20
>>>>> [ 5554.807401]  ret_from_fork+0x1f/0x30
>>>>> [ 5554.808206]  </TASK>
>>>>> [ 5554.808699] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> [ 5554.810486] Disabling lock debugging due to kernel taint
>>>>> [ 5554.811772] BUG: kernel NULL pointer dereference, address: 0000000=
000000008
>>>>> [ 5554.813236] #PF: supervisor read access in kernel mode
>>>>> [ 5554.814345] #PF: error_code(0x0000) - not-present page
>>>>> [ 5554.815462] PGD 0 P4D 0
>>>>> [ 5554.816032] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
>>>>> [ 5554.817057] CPU: 1 PID: 2590 Comm: nfsd Tainted: G    B
>>>>> 6.0.0-rc1+ #84
>>>>> [ 5554.818677] Hardware name: VMware, Inc. VMware Virtual
>>>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>>>> [ 5554.821028] RIP: 0010:kernel_sendpage+0x60/0x220
>>>>> [ 5554.822138] Code: 24 a0 00 00 00 e8 a0 98 83 ff 49 83 bc 24 a0 00
>>>>> 00 00 00 0f 84 9f 00 00 00 48 8d 43 08 48 89 c7 48 89 44 24 08 e8 80
>>>>> 98 83 ff <4c> 8b 63 08 41 f6 c4 01 0f 85 ee 00 00 00 0f 1f 44 00 00 4=
8
>>>>> 89 df
>>>>> [ 5554.826047] RSP: 0018:ffff888017ef7c38 EFLAGS: 00010296
>>>>> [ 5554.827192] RAX: 0000000000000001 RBX: 0000000000000000 RCX: fffff=
fffa3b173b6
>>>>> [ 5554.828715] RDX: 0000000000000001 RSI: 0000000000000008 RDI: fffff=
fffa6b16260
>>>>> [ 5554.830237] RBP: ffff8880057ac380 R08: fffffbfff4d62c4d R09: fffff=
bfff4d62c4d
>>>>> [ 5554.831757] R10: ffffffffa6b16267 R11: fffffbfff4d62c4c R12: fffff=
fffa545e6a0
>>>>> [ 5554.833341] R13: ffff8880057ac3a0 R14: 0000000000001000 R15: 00000=
00000000000
>>>>> [ 5554.834881] FS:  0000000000000000(0000) GS:ffff888057c80000(0000)
>>>>> knlGS:0000000000000000
>>>>> [ 5554.836590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [ 5554.837819] CR2: 0000000000000008 CR3: 000000000677e004 CR4: 00000=
000001706e0
>>>>> [ 5554.839374] Call Trace:
>>>>> [ 5554.839919]  <TASK>
>>>>> [ 5554.840400]  svc_tcp_sendmsg+0x206/0x2e0 [sunrpc]
>>>>> [ 5554.842066]  ? svc_tcp_send_kvec.isra.20.constprop.29+0xa0/0xa0 [s=
unrpc]
>>>>> [ 5554.844194]  ? refcount_dec_not_one+0xa0/0x120
>>>>> [ 5554.845239]  ? refcount_warn_saturate+0x120/0x120
>>>>> [ 5554.846275]  ? __rcu_read_unlock+0x4e/0x250
>>>>> [ 5554.847199]  ? __mutex_lock_slowpath+0x10/0x10
>>>>> [ 5554.848171]  ? tcp_release_cb+0x46/0x200
>>>>> [ 5554.849039]  svc_tcp_sendto+0x14f/0x2e0 [sunrpc]
>>>>> [ 5554.850667]  ? svc_addsock+0x370/0x370 [sunrpc]
>>>>> [ 5554.852285]  ? svc_sock_secure_port+0x27/0x50 [sunrpc]
>>>>> [ 5554.854420]  ? svc_recv+0xab0/0xfa0 [sunrpc]
>>>>> [ 5554.856187]  svc_send+0x9c/0x260 [sunrpc]
>>>>> [ 5554.857773]  nfsd+0x170/0x270 [nfsd]
>>>>> [ 5554.859009]  ? nfsd_shutdown_threads+0xe0/0xe0 [nfsd]
>>>>> [ 5554.860602]  kthread+0x160/0x190
>>>>> [ 5554.861400]  ? kthread_complete_and_exit+0x20/0x20
>>>>> [ 5554.862452]  ret_from_fork+0x1f/0x30
>>>>> [ 5554.863265]  </TASK>
>>>>> [ 5554.863756] Modules linked in: rdma_ucm ib_uverbs rpcrdma rdma_cm
>>>>> iw_cm ib_cm ib_core nfsd nfs_acl lockd grace ext4 mbcache jbd2 fuse
>>>>> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
>>>>> nf_reject_ipv4 nft_compat nf_tables nfnetlink tun bridge stp llc bnep
>>>>> vmw_vsock_vmci_transport vsock intel_rapl_msr intel_rapl_common
>>>>> snd_seq_midi snd_seq_midi_event crct10dif_pclmul crc32_pclmul
>>>>> vmw_balloon ghash_clmulni_intel joydev pcspkr snd_ens1371
>>>>> snd_ac97_codec ac97_bus snd_seq btusb btrtl btbcm btintel snd_pcm
>>>>> snd_timer snd_rawmidi snd_seq_device bluetooth rfkill snd ecdh_generi=
c
>>>>> ecc soundcore vmw_vmci i2c_piix4 auth_rpcgss sunrpc ip_tables xfs
>>>>> libcrc32c sr_mod cdrom sg crc32c_intel nvme serio_raw nvme_core t10_p=
i
>>>>> crc64_rocksoft crc64 vmwgfx drm_ttm_helper ttm ahci drm_kms_helper
>>>>> ata_generic syscopyarea sysfillrect sysimgblt fb_sys_fops vmxnet3
>>>>> libahci ata_piix drm libata
>>>>> [ 5554.880681] CR2: 0000000000000008
>>>>> [ 5554.881539] ---[ end trace 0000000000000000 ]---
>>>>=20
>>>> --
>>>> Jeff Layton <jlayton@kernel.org>
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



