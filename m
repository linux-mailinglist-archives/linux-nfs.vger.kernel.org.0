Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6137B5FDC49
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Oct 2022 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJMOT4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Oct 2022 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJMOTy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Oct 2022 10:19:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCF3880
        for <linux-nfs@vger.kernel.org>; Thu, 13 Oct 2022 07:19:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DE1FMm029207;
        Thu, 13 Oct 2022 14:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jEoJG7J+kzbB9gQT2zc/TKfaREBTjPZkS3FJN8DM7mI=;
 b=L+hnlkm+ux31zUoSQfcNcRnprNG9LukmGUtEvFX0Iw0Oqb1QTGqHJQOKajVcJjgrOCWR
 KgHYps9rr5JLePDvJWw6OJihHnvw8ImL3Rdc7ISadhqp8QD8Ek4T+8/kIj28tdYU/PT7
 f84w0oxFyZUHp46bmAwYE2R58+/TJnM3ZXeyrStV/ebkNX6frMqeCRNaxcGgzZHYFLcd
 vWrtLlSTgcQ3A6Da+/6YU9AvioVpq+8TAwSwkyWv0Y8dp/0UOq2j+Fi1KHYkotUIY/cz
 0xf0wf9pUo/VyW+p3dprWIR8s5v8Dy1+7orNKSS+YL2tmgRfX3ZKXU/mQBiBkM2DRno7 fQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6kgmr73v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 14:19:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DDCLHV019360;
        Thu, 13 Oct 2022 14:19:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yncmuna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 14:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlLK+cnX+iSX8N1Qt8yE/ecJhZ1lPkHvjyterHI+f2AR90a9jGcw74N2i1oWYebFrE9UtSuz0EPVLpBmWkVB8wgUy2RTQ8mh7aOj5JJlaxoDWC3TwUOxQK3JG4SBgumdATGQUKNqQ4KexD6gdqHrvSjghYY88zdO+j7FVSpwqL6Fwr17KtdQKuW0FqM3psPxxik0ZZ4ToiE6LraCz4TpCKe7y3VW+eKpwM7QcIoH4Fp6+lpRwj4uq5hnH9rFC6c6p/inPcX+FX9cll5z1n432H8IKLKVVhgX0CmiGnyEXTGb4Va36pQANkv2zD3WxmSIMlFkVYiPZ3wnNQrIUoid+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEoJG7J+kzbB9gQT2zc/TKfaREBTjPZkS3FJN8DM7mI=;
 b=WcxVz46CwG3gx7BDMJNAU7d8t87NrIMfunGyBEFr6CS3QKfKut0lFGzyAy5vWHXbqMD0Aq1/UJEvZle+AcaUjvSJz6yAFEVAUBpoqO8t3LmY4qSnyWDF6JMKDa9WMo2FStiPcF1DbO95GqNsKu6LFgPWo+P0T4Mwe64vdiVMuWlX0SwLYQ789ENvsDD9F/YmxFRcK5ileQPk3ttjXaBINLtrn9U8AupRf2tITNydPVsn9AiwRcVroYBGjhzNz6bGYVt/N0InC9X1rz2PI7FccQwGEHBdz5GDZW+qDkLs3gl2eBLBpEx+OJOH7FQQD+uGk/aRV4c34LR4eF8AAn3bWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEoJG7J+kzbB9gQT2zc/TKfaREBTjPZkS3FJN8DM7mI=;
 b=aBilTnWKm5/KfHMKPukzQTyNvwGvD2pRBTKjTypp7EdIea6wu4KjExy7wkcTh2NS44YZJOjhtR+JDVEcmbZtFdJ05An1Fg3MiKVtODhoHq+ZQpdmEbrC2dvEIUbXUR+j4fvqOwuPsgXFeAu06XYM+CKMn0qzyUJbxHzj4wYXNXw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4482.namprd10.prod.outlook.com (2603:10b6:303:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Thu, 13 Oct
 2022 14:19:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.022; Thu, 13 Oct 2022
 14:19:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY2Z+f4KLIvxFyZE+pJJ7lJKAPUq4IWjWAgADUNACAALMrAIABAksAgABpQgCAAR1KgA==
Date:   Thu, 13 Oct 2022 14:19:42 +0000
Message-ID: <E69F66C3-C17E-4397-8329-8B6C2D2E2F0F@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>
 <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>
 <166544739751.14457.9018300177489236723@noble.neil.brown.name>
 <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>
 <166553144435.32740.14940127200777208215@noble.neil.brown.name>
 <4004BFE1-C887-4A53-9512-8A264E0361FF@oracle.com>
 <166560951668.32740.3528791072339550207@noble.neil.brown.name>
In-Reply-To: <166560951668.32740.3528791072339550207@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4482:EE_
x-ms-office365-filtering-correlation-id: 0190d27a-e13c-4b64-afc4-08daad25f896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 263OCfrz8XUflB8FYyClNFHxt46E9PXU47kQsWsMPu/HChaALXIYCGjb89DXASOT7GAKmfa2N6q11LZ8uZ+Seyvs+em5tDWOzcD0dM/jOe34rtT3HAj49Md43IA1MxZRf99ygx+uymA5J2QRumKUhIqwktI/8r64LCk3WuU8sEHKNHYboBxSwEFxH3I0T1qNWXWNyfqyYnpyrsfd+4iQmT+ynLbfRYnUbUFEeQyD59udTg/3nID4gBWbqj3eNjpGyoMNQuW2I+I87P9uQCDnVbSSE3pfYuFICq27iM8iOEXx60G2meqXFCfpBNfbPQOgil3YpEuMLq6M2s6+qkaVhWu1CPW6TNgpUwC7PAgHW20UKTsEfU+GjCHlZY2UQXBkDkELe2RqkUoHt03SmPZ2ALs9UU/MuBjdJWj8dWGV7nqx9LGBBn+zZQDcYui4NVrwQmXWCVi3phQVlZj5j2ONYkGuaqU1nZr68rm6Y9o6qe9vC2A3gC2ECJ482VL87aj0bZ/E0UYCzxw+S9OkGJBXZhN0THPw5eOlB58ys3GmBn2zCdFEuG2TYAENcdpgT9cQpNYZG7LYjZX4wAwEkRfma6rVrbAlH4RUEPS1dCxYqDuywaYQu7rH/R+LYDAJnCglyASzzkB92GPW21Ej4t0EJbfdSzjvnyU9cVEHlr+nLZvtbN/avKwPZtBAkKX+wYDKy2zdGeZsWoydhGpugHjmvqvjiWGKvys1iNs9hIFqGGqbOxOiESW3FJRVm5bXlJ7018a2NBFv+vzUptep28s7QIfLp51TtIkpL0Tloo5mu/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(316002)(33656002)(6916009)(8936002)(26005)(186003)(6512007)(122000001)(5660300002)(2616005)(2906002)(8676002)(4326008)(66476007)(38100700002)(66446008)(76116006)(91956017)(66946007)(6506007)(66556008)(64756008)(36756003)(53546011)(41300700001)(71200400001)(66899015)(38070700005)(6486002)(86362001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b13QCl4Bz2JQsmuRe9No2oJHaRZqY6B/7NKLn2KWRdsiLEyJc2CiIg/go85x?=
 =?us-ascii?Q?C78DsquIy5HN/5AormXU6+iu/SZzJHZg1ja+SeJouh2H/P1XNrZQ5U+OeSRS?=
 =?us-ascii?Q?9NYNrv/CFy0SExOCECvmHdUQLEMp+FiWVLPoJCqBIy//IW4iZDQwCBTs0h6H?=
 =?us-ascii?Q?+UQ2dpw0RoPG7cjLYhXYYBXE4Yfii6PbmE1wV4VbTTeHn9evrNYBRS9T9xcC?=
 =?us-ascii?Q?StYdhg/7aNbVEoo0FBlUsgEqQyW7dDzPXifTGqY6DS0xNfY4lU6Ph+9lBQWg?=
 =?us-ascii?Q?Uehs2i+qqbsdw8V/gD0gdxdoBV7qxr/XVBKvaEKo1VIqM21RWvG8DVqujxdW?=
 =?us-ascii?Q?ASkdSTXXhxpU3aKzdJfgK1en2kViGzt2ZBRVQFEqXg9/YUUjd2DTGTKssp1z?=
 =?us-ascii?Q?kSyqHXqs9xqZW3qqjRf72R6ALotiYM09d/0jR39qA42l6Wm4ZKhGiFW1PKPi?=
 =?us-ascii?Q?yykDCS9ia1DodJAlNwqEbKYIWNmOkWjVM21jCAMZiZd/VxLvyK4QWIxNVBNh?=
 =?us-ascii?Q?j+dnFVXu79RKdo9RPl6ph+GhIuU8j5H5eGVh9U3k0NV+uLog2/G1fuWVSAAM?=
 =?us-ascii?Q?x+rKARQRvN5ws9yQ7XrPmJAt8S72bMVL0MrslMWUg0yVdhqMnOVVhKV1Jt/m?=
 =?us-ascii?Q?6dkRBLN5SlvxSZeUc/seOq9XBikh92Oet38Jfl2CxbBjgaUtFu7oFNPHG3oM?=
 =?us-ascii?Q?Tw9iwvchkv/oJcViMxg3XcTB1DIKRUqjkqDTW38w5pNr5k6Qp3EN+7jcMK/m?=
 =?us-ascii?Q?zacGNPr+osqcbxsZl1J0x1UjHv/srdX/H6XM0MLfmHFFSyZgud4AGccPLeXh?=
 =?us-ascii?Q?FcF3NXqUqT7t4bMbxu1+3UcWVXiK4p1ljTkVCwPMZACHJ7Z48p2mMSdxx4uu?=
 =?us-ascii?Q?RvphtEzZSwl51EK7KzARh8pDt4VPS74muH64rQwF7m2Mve5PP3jUWch+4uaK?=
 =?us-ascii?Q?Z8/yI2MyLrn06iMHmPNy94gekyzMOZCrNxN6e4jSeekW1GoXnhrCyV8qk5Ux?=
 =?us-ascii?Q?SAnYcQhV8VSAznv3+GI5xaiJ84fBFkt0Bsv6Atb0b+GgzdGXmMgJAJlse7yh?=
 =?us-ascii?Q?9nwHM9ogtxqhTw7SOJ/4SWcIaYGUYuakFjjJSxRyO9MQRurdBrAS0V9rqRDW?=
 =?us-ascii?Q?KzuRDna2sfr2/HEFSWvA3K6Duaio3+eyEbpyceHcU6bL10ENdmZBMz1NUTNr?=
 =?us-ascii?Q?ygZC5VWNAMtjGs5JCWbpZA37gxoUIZpVB81W2WfQWlqcsvjyEuyqz9G2eIxS?=
 =?us-ascii?Q?osS9UMlbJ+ynbMorB/Ktpfk62N9403PxG6dQtoD57aj3QiBkpZTj5chzih4G?=
 =?us-ascii?Q?JmQEIOmSox8ru6sNyF4wE+lNriXtue0Is7YZFADod3n+3yksenjkhWNTQInZ?=
 =?us-ascii?Q?pu+0AzCcTsPCH1KUe6iDmKJ+ZdadUk9U28y8Jmxlb7GymkPVWL1R7z79RB70?=
 =?us-ascii?Q?/6CvwSa+wo6wTP7qlOhIURUJ2OuKmX41kl649Uqv8++qqzhiNZMKbwtbne5M?=
 =?us-ascii?Q?u/jV6JQFtQBa2azzbNIelgD8zwEoBY52A8Gsbsf/W4XlTmGZ9Uwh3qtGfaXI?=
 =?us-ascii?Q?pRNi7O0jwk9twtg/pz0cmis8V92nRxQBkDIENC2tQdMPJkt1lW1HGCKYoN9v?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3CBECCF3DC8259478EE97408CD89FD02@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0190d27a-e13c-4b64-afc4-08daad25f896
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 14:19:42.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSNEcKDUSbOz0nNbj/Agi1DJDHUF0tQcx83TCIPmOkxIB2lYHY6yiMpEZaUNT9PMhXPhOaEH1HPzTnurw18naA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=972 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130085
X-Proofpoint-ORIG-GUID: GuoPpfrZyvPFzdsWZIQQiJQ3HyxuWIlt
X-Proofpoint-GUID: GuoPpfrZyvPFzdsWZIQQiJQ3HyxuWIlt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 12, 2022, at 5:18 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Thu, 13 Oct 2022, Chuck Lever III wrote:
>>=20
>> I think I stopped at the non-list variant of rhashtable because
>> using rhl was more complex, and the non-list variant seemed to
>> work fine. There's no architectural reason either file_hashtbl
>> or the filecache must use the non-list variant.
>>=20
>> In any event, it's worth taking the trouble now to change the
>> nfs4_file implementation proposed here as you suggest.
>=20
> If you like you could leave it as-is for now and I can provide a patch
> to convert to rhl-tables later (won't be until late October).
> There is one thing I would need to understand though: why are the
> nfsd_files per-filehandle instead of per-inode?  There is probably a
> good reason, but I cannot think of one.

I'm not clear on your offer: do you mean converting the nfsd_file
cache from rhashtable to rhl, or converting the proposed nfs4_file
rework? I had planned to do the latter myself and post a refresh.

The nfsd_file_acquire API is the only place that seems to want a
filehandle, and it's just to lookup the underlying inode. Perhaps
I don't understand your question?


--
Chuck Lever



