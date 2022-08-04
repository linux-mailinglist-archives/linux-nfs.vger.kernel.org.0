Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FCA589EDE
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiHDPoH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 11:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiHDPoG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 11:44:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E522558D
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 08:44:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274FGE8G015221;
        Thu, 4 Aug 2022 15:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=loUrdMkm/3q6eb4+E2kKk+G1YdMx01/DuBxR683Akyc=;
 b=ASosZ+i/Ue+SbdXjst2tHk8Zn+BfZ8L8IgtBAwLEq3dVcOdQ8dqbj2HKyESIQ1esvOht
 YZ/4MztGstaetI5LH9v6ivNrDv0fxY6qA9Ega91ccaiKDc+Kumi3CIxPu5skxyZVx6XH
 E9oeCTtqi332x3DnDNHEjb42Hxg4+vnJfNnkKQJv4zqBtzRR0P16Wr9lPy4qNxuhkj/S
 U/ZZec3RVGiRxoKnoDLbeRUh9QUizGbxO7rtkhRhyp51MCDyfgxxZwRZYBi1Fz5cLuVC
 tTXYIeST1gNIyyPw1v5YQJjOcCfi95N53mSpMKlSq8SgYl0xjIAhlgMVXRzPYgE+nUSz FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2wevu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 15:44:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 274E3HRW003064;
        Thu, 4 Aug 2022 15:44:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu34e7bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 15:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbzWemYl1ZoUr54aHDLQhYhYQ7HPQe1kzUA2R3fnOxBoutvHt0ORCPRFO1kyKzdRwVNQoHHlcVSwwDA4CM7O1FhHGy7JvE/EzDg76FXGz2RKxlcjbR5mjyjleQ4KqU5cJ9S6fy6+ugZs3v/PtFGF8K2nnvLKsK7YRke7ArD0ncJwQbSADPh8HznCMbGAMmRJ+eNz/yWp9NFdpPnF9uHgLqqRDZ2Ess4zJXm13SQEogi3u8ypbQvsAQ6XwSw8VdFlvXmjheM2YUgLXykghFnbWT3ls0BlsTAcf8of6DlvtzDnxXQWiOc9ttBExxGAeykyS94FnYuBiZ8sh20/SLb5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loUrdMkm/3q6eb4+E2kKk+G1YdMx01/DuBxR683Akyc=;
 b=ZiQ+/FQrMMvI5cUBtCa530J8IzVkx8W4VxsvwkHtxDEURS9nVDvTIg5XbhA1gmmburUWayyIN2AdmFxRcZNNptfoPrv6RghUXwY5bU2Q/btEZLdr5NxiRShjaMol0NekM+IWFQOCpU+H/ij1LWldwdfnSlCECuduMv802ISY7mcEw0Lsn7LeeqRDB5c7926cOS4mpwYOGQ+3H583WaXMhacqe0edGQXTFMZYHuWUzlzYQDNMuQDDR7lmsv1pJKpy+Sx7CX8tePMDd/aBvRscZ4s9ojQd1t6SfPbGZ3zhCZbzdBlxL55n5u5ZgZmNpPKHhD33rAONxbJWPqlpUBvy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loUrdMkm/3q6eb4+E2kKk+G1YdMx01/DuBxR683Akyc=;
 b=ZtIj4M+k3ae7/e+bp+cra+u7e31n+ekYVD9R9RKgHoWJjv66mor7dtjRI7VVQ4XmI6vrp1b2skDzJLhcw/uwQsutFYtvnYjAvTuQ1QjEp1TRtVeQJuCyEM56qsj99lkGkRKLbW1USMG510tWcbPII+EdTIZs6InSPbSvqPyqo/4=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by BYAPR10MB3272.namprd10.prod.outlook.com (2603:10b6:a03:157::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 15:43:56 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9d56:faf4:482e:e6f5]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9d56:faf4:482e:e6f5%9]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 15:43:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: pynfs clean_init issue
Thread-Topic: pynfs clean_init issue
Thread-Index: AQHYqBYvcZZh6BVquE68kijT9LgD6K2e4EEAgAABlIA=
Date:   Thu, 4 Aug 2022 15:43:56 +0000
Message-ID: <1C391A45-B2CC-4C90-86DD-1FB9C2000E7E@oracle.com>
References: <F80796C9-DFCE-4C7A-A2EE-4EB2075B9007@oracle.com>
 <20220804153816.GB9019@fieldses.org>
In-Reply-To: <20220804153816.GB9019@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41e8fcee-46f1-43d4-1706-08da76302430
x-ms-traffictypediagnostic: BYAPR10MB3272:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9yEIGFc3KB3zNxS4bVp6cMrN14wpkfsOYNAG+cpZJn3XvfCD3ibMvcaj8cvttozckp8l3ivoJCj8DIHb6tXS7mbyuNeOyBJs4cY7slqGB52v9jouXM4t40X0aIW8PClh+LxOvJJa+b8roxigp5wTjlXWYd4ypXm4gofKggasCMboUZzLNVg4OiCOHXJVkQnF9oI5DqeXJhbPYtK00NifBlqnAVlVPCkQ7uiiu+omW8vBc4SxtxzFoFJuQ7GMUAjV5wqTabg+dSKPsbHo37l1APsUnQVSSYW7Ql1hWs3ngNpdyNeJurkbsAsLOUGQRnSKwKL/mgZwDQlsTDuwk41BIpBd8ArWdighGk+PrUN+f75rbvnjaU0g6zvS+bTj0wkZcsqGn3S8BClFCHcXezL4JDVSvEjOPjRTFMasCgJa7iimCJBYF+cfmh2xJ0mdRQiMWEGhRaLZa4U/yuCt0IT1/cJjGLhFdtMdLBkfwud5H20GqZuSP0G3wNMcz089GTDP76gbZVn8WrNcjEJuMpWAJ+zb9beKqtAjPUXmUoXbQkWh/W9LyWA9EqEe9FZovTt8wlMpqwbks+bDlXytaaZM3XA8R8t4b+w3uaHipnfVUumocvN3w8XfmUMW1s//rXBigm/Lq6gI7Bma42fzTT/9fTZO3/yHXQaRc6T3Vm089U7IY6cj9AUfQg5gXNviYH8QzKk25fx5BYf4LwRHwTPGZgFf4lJ6A6QImnqki/HPAQlh5bdaDflxND0PuCK5ZIhOr7X/X1N/IUYvOU2CDdMTnv7t+Fgb68wKf+cJjuwMdviveCuwDmIUvHSj5YTSuFKRrdBR0BPOw+j2CqEAAfxFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(39860400002)(346002)(376002)(8936002)(6916009)(64756008)(66946007)(2616005)(4326008)(66476007)(71200400001)(8676002)(66446008)(66556008)(38070700005)(86362001)(5660300002)(316002)(91956017)(76116006)(53546011)(33656002)(7116003)(186003)(83380400001)(38100700002)(41300700001)(26005)(478600001)(6486002)(36756003)(6512007)(122000001)(2906002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4P3X4fJkHITlexYj7/VpRevuaScsBiSsWXN4jm5Uin1601y+SFJm9oj3bvCI?=
 =?us-ascii?Q?tkeDkd8YTPFLpun5X3AP1Nx6OOx7QdzDCBJVv865k+0BsxrC8vZDPVI8aHxk?=
 =?us-ascii?Q?NtYudrJdO5D0Ktz90Oeen2qNSmtZQqvrfH5p6GBcArSW0VGZ4rv0XW9li2hy?=
 =?us-ascii?Q?Thviv+89Ks+A47MY67pKqWsniQirwtvTh4WV4HxAvQoluLU7eo9rIJdjH1DP?=
 =?us-ascii?Q?6U11e+pGY2gbyNe32zo5dNnDpVBoqErpvMnim2DC2MzkA19KtAN/2/Aj0QuK?=
 =?us-ascii?Q?fVCnYfHk1Rd7kTwxq+SkgUe0KLOEcdMXIcV+CfRo8KVzngMYyEkQmI8EYy31?=
 =?us-ascii?Q?oaakUVPJLh8fLhnBhYgRYE31/VzcIcyBKxw7B04LJiib6/6/2Ycsj3IiV18Z?=
 =?us-ascii?Q?qf+WN+eE83KxMUBQDl7b2OZiSwiG7PTjgmieNe6SPVl47Yo0BZWw8XRJkUv0?=
 =?us-ascii?Q?7wfQC42aUO7oVzTnZqCmxXwntk3ioRYCO7MZUXtl0swnR1Vv7f2tbntRlnl9?=
 =?us-ascii?Q?JQxnQ96g4aXGMhZHl4F5SuMVJh91Sg3uu2kwNT6iMPX2tz/0Kv4B04UuTYjq?=
 =?us-ascii?Q?3dLSEc956K2HOfAUwAl0dlXv99BGUN9YUJJ89asB4+13X//2dIUljf+lXuss?=
 =?us-ascii?Q?Ig7XEdXPIpvvuQ4y4KNxjaXhFbgByegfCg6lWXIIFRgoxOlLbFsv0yp5JBWT?=
 =?us-ascii?Q?yd7wxApAXCxXOfE8JbLZ5X2BLUL/50VE3SGi8wLbKt2Lujd18Y5L20/0sKLf?=
 =?us-ascii?Q?UyRMYZjw5HsSgXAxVhGOX9Nyf/Ar8FDO9YMKWpAvpmyE27Hz5RON3lPWMD7W?=
 =?us-ascii?Q?thxAL6Ky30poDadZnMVqA3ro/xy7e1/cNvJ2wgfppaCx78s0YiIlmfIRQq3d?=
 =?us-ascii?Q?xUUsvtZUpIhtE6TsaJFpT6O3YpnjX4s4D4TXMTE+3p0x6KlI9fQwe21nYbvw?=
 =?us-ascii?Q?rEKoNRIUVmvpwNATMgG3SJF0mvndgEyjytt88vWJBEx09ifP7qKUG8l/0Uu8?=
 =?us-ascii?Q?hebs7ogqHFoNk4Lu8M6PmVFqKZTZubIWl38G34TC19hOXguQntfphjGDBGN8?=
 =?us-ascii?Q?l3JMhGlaLLp+ilS65+HbrNtVYgxGlAuCGm86SlN28hO9H5MFi4He+W1bh4Yl?=
 =?us-ascii?Q?JQIwdP+gQmsb5AV4CrESW6y8fWdw7mr5FwkbS5OwWkMnhalYZjJCfdYkBHXd?=
 =?us-ascii?Q?fr1RS+JTNGAd+kDOqkEKoFLroQfFnP0hhVk20+UXS3TLIjKhCW0CwWQ7d2Qd?=
 =?us-ascii?Q?lJzZg3hjpz7zrNCH7ZYa53GUcf2nDLrtOtyspeM8Q/lJsVqF5HQHdmJr+iaZ?=
 =?us-ascii?Q?Y/mz2oRxVe7PtpKe9rjiIDF7OVQtwWULTn3Oe88pcyyfQdIDeK9EJC8lHMk8?=
 =?us-ascii?Q?AEekg648HqpqCE1/0swRoWGZQnQOPs8xeiP/r+2dp7kXPkBHwqGmZA6N4JFj?=
 =?us-ascii?Q?M0GEiADdIRfmrVP2paGaQdJN/avWd3DpeMuqX0iRavOouXewMPQ+kmR9KzsC?=
 =?us-ascii?Q?1gulGOSXtKUCGQzmzrGulcrbL2FOCEg11p1mx7syjjg2gVP+3WLrOHO/3UCN?=
 =?us-ascii?Q?mYar4gCx1hMldFu3WwDaVRBVygNVJC9XcJE6vpwOIYxndtW02/CRBh/IlCwf?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA7DDBABFBBA29468FEFDA19265E2760@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e8fcee-46f1-43d4-1706-08da76302430
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 15:43:56.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uciWWhpVFjOk9e33seeaSjknVUpipnUFjTDoSGTWQuSo+J78XOSDCOG4cunZ1KsIxfWU4jv6x1alLmUOvCClhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040068
X-Proofpoint-ORIG-GUID: MrTJV0fH51JCILeT7jIR3evuihxWzVNV
X-Proofpoint-GUID: MrTJV0fH51JCILeT7jIR3evuihxWzVNV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 4, 2022, at 11:38 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Thu, Aug 04, 2022 at 03:23:44PM +0000, Chuck Lever III wrote:
>> Hi Bruce-
>>=20
>> I'm running DELEG21 to unit-test delegations, and this message comes
>> out at the end:
>>=20
>> Making sure b'DELEG21-1' is writable: operation OP_SETATTR should return=
 NFS4_OK, instead got NFS4ERR_DELAY
>>=20
>> I guess there's no callback service running during the test's clean-up p=
hase.
>>=20
>> Then if I run the test again immediately:
>>=20
>> [cel@morisot pynfs]$ sudo nfs4.0/testserver.py manet:/export/tmp --maket=
ree --rundeps -v cel
>> Initialization failed, no tests run.
>> Perhaps you need to use the --secure option or configure server to allow=
 connections from high ports
>> Traceback (most recent call last):
>>  File "/home/cel/src/pynfs/nfs4.0/testserver.py", line 394, in <module>
>>    main()
>>  File "/home/cel/src/pynfs/nfs4.0/testserver.py", line 346, in main
>>    env.init()
>>  File "/home/cel/src/pynfs/nfs4.0/servertests/environment.py", line 150,=
 in init
>>    c.clean_dir(self.opts.path)
>>  File "/home/cel/src/pynfs/nfs4.0/nfs4lib.py", line 579, in clean_dir
>>    check_result(res, "Making sure %s is writable" % repr(e.name))
>>  File "/home/cel/src/pynfs/nfs4.0/nfs4lib.py", line 906, in check_result
>>    raise BadCompoundRes(resop, res.status, msg)
>> nfs4lib.BadCompoundRes: Making sure b'DELEG21-1' is writable: operation =
OP_SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY
>>=20
>> And I think this condition persists until the old lease expires and
>> the server permits the client to delete that file.
>=20
> DELEG21 should pass on any recent kernel.

It passes, but leaves the test file so that clean_dir does not work
again until the old lease expires.


> But possibly cleanup should also be better.

This bug might prevent running these tests in an automation harness.
I'd say cleanup does need to be better about this.


> I'm not sure what the right fix is.

Brute force: keep trying to delete that file if clean_dir receives
NFS4ERR_DELAY?

init_connection somewhere needs to set up a callback service and
leave it running.


--
Chuck Lever



