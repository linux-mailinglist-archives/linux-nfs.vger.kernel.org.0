Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E596D6C8634
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Mar 2023 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjCXTu7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Mar 2023 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjCXTu5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Mar 2023 15:50:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4AE20042
        for <linux-nfs@vger.kernel.org>; Fri, 24 Mar 2023 12:50:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OJitk4013941;
        Fri, 24 Mar 2023 19:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tG58pRfX9zoiFyP4MZ21Ppje30wUE6F8N9TsVOCdQwM=;
 b=sDozBIjLPSb1EJCmR4EoQ8zS8HGPbQMaOTrH6ZxZb3T+FLGMO/9yKYnp0Qng8gX4J4JT
 fhpFxSPCkaRH44EJGjTjPA+6eq/P5ZliZioYGg7/dFVPo6y87bwi4mYvhb2+dxu/wuYp
 fhnIEfxwNxF7VDSTqQDbnH5ijMCrlD48McxCIQdiIDDlBFTE4p/hmxdAP0KT74XTNnZy
 bYUdhNTAW8EHdiEHc2/0761+t1uGTZs7OcyaUlzCegrPGl4vyCfYn8Rw4nGbywruSTb2
 xY99BcWcLo5N7lTWepm/ahd64b7l4lLgjY5i2KEO3Y6yT+8j5BSAx2VFzVk8Lo0s0aM/ dQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phj9dr0ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 19:50:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OIoek8038081;
        Fri, 24 Mar 2023 19:50:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxpye836-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 19:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cle7tFoiiHZSMTyqmQZTTXVzxPAFqJT7e3NFVtqVxjgFFjEnAIGrnJzMXj+ttNo5pbzC8W1z/JU5h8waWUy++WCTSc1c7lQREixjw/FYKtQq4G/jg7ufBsDnlVYsmP6L2pwtyyrAiKTRtUBAmJdziQS1c0h29EWkDk4td6jXfuLBHrTxiDL3YbdShDgcKXd3GtjijB1pwThNm6k/lfZZ/BkxsfCEKmhKF/WhDnJHYNGMo8K6QkRKAjIKUGBb0Tr0ZT356TsAyfc+KxovKOYp+fq8zZx/6rMmjOy0BlYXEfha4af5ggru9SzkmMhcn7tAxxDMJNuQCvrgNwKl0A1zbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG58pRfX9zoiFyP4MZ21Ppje30wUE6F8N9TsVOCdQwM=;
 b=AKHmsWXa2DYqAeR9s5how3OdgfPL/woViDyZB7w0nlmMy6gYiALtbY1Z6gK6V06BwL4lu796es5vTJHG3UPbW4VY5R9bQYa24nhNuTWblVP5p+QpfPmQ+mzIQqpr7J6YMDcmxqkzf6HkQDpkoAMa5zzAlw8zWe13+/MCAEuU4PNghxA8VIPvmqRiOa+HbLhyb0ZgnhwYMkhWfCUkrS+JiRlGD/Z908aI+UZUj69btOvWufLEijXnQ3vEqcmEZ14i/R2B2pfoXY8wTNI1xpoSmy7oEsaZfLslnpPOERm6SS99pZBUmArE7gu+DU0oeAMGjwnhgSDkWrYJLEzo8n+/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG58pRfX9zoiFyP4MZ21Ppje30wUE6F8N9TsVOCdQwM=;
 b=wP8+4EgBvMJhZNNFwCoROJiaHeQbdHz6bOKn523FTiuUSmbv9tKBv59L6KhpaY2YX1bKNPL5Gp7JVPQnCx52frjSGaDzZDQoLpkb8eQYpOUTmkCB3Yy7R25zzfAMGnC6j8juFnBNGCozgSzgShGu0GtnOJhTaS+79VdGQY6wKq8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 19:50:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 19:50:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] nfs-utils changes for RPC-with-TLS server
Thread-Topic: [PATCH v1 0/4] nfs-utils changes for RPC-with-TLS server
Thread-Index: AQHZWzlAXSqCgHySYk+ZhP0eJ9zOUa8FIOaAgAOKbACAAAErgIABm90AgAAVC4A=
Date:   Fri, 24 Mar 2023 19:50:46 +0000
Message-ID: <A6DA5D88-5DA8-4F19-B07C-52B32F41A962@oracle.com>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
 <d5c93e97f10a8ae803efaad02559dd118e9b9b6f.camel@kernel.org>
 <da936d7d-a864-a2ff-64a4-a295653a6aa7@redhat.com>
 <7AC1BDBB-B6E3-49A8-A468-C045F0218495@oracle.com>
 <89a49550-d7f2-22df-5f6d-b9b8c66604de@redhat.com>
In-Reply-To: <89a49550-d7f2-22df-5f6d-b9b8c66604de@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4294:EE_
x-ms-office365-filtering-correlation-id: b48bcc74-0d21-4cc7-16a8-08db2ca10f55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DvFeKQBFkxsC4hzWoIfjsy3mmUT/3+MzufblQNnZ8s22eysihY/+J2eyU2XcfV+YzQkfjSFWdHEp/NIG/OnrfrVhvSm0US7y1bwLfOfMlQg6hcR4Qsqu1P9BfpWoda1GPoiWiWt59UwH5f0j2gWswLJqKzRDzCHUQz231FdAyc9v31YFxSYYv6kjL5K/BAjDrA+ZKGFxQzVC5OyDZuwy/bVEpOkZgJS2OwkVSqDz0n8djzKhce/GprWlBlmDp4DmbwrMr6DwlcJhrjsVqsMSdUFOFyTzVXe2QyaVJZuSx1F15IhgX6N8JbQpB8v7SWpPQudmgechyWj9U9m5qIPGXjONmhbj8L6S3jSwp1M/9EySNRjc5EyOgk5oFMKdOu50L49W6fAhwaNNp/cP3JTmAARVI/lhjKS/GwwSOkatMSWBEuxIOwD9exCljtU4QLOvzFcF07r4N2Kuze3x9qu648ev5igEn9NLGKxw+mWMZL/c++xMZiIA7GloK09tja4j07NTusuvmZSKnNKsEgTBA0PsSpn9Jq6ON/MRuNf7vKdGHT4NkD7Epksbw1UKudETZ0upng/XGc2bPhb7TlPXjdOaBpAVzonNCzlT580xfSLe+dDZ2RiI/E8BlWuY9KKcdnmiaxzExi2Y+IDKd+lfsD4glhcErvvWTmlbTPysla41aDNFJAbEjGEyRtbbWTD4R9M5F8mAtCobs2FFwnLh20iGi/N7RR20jEyVAdYaLFM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(66476007)(64756008)(54906003)(316002)(6486002)(38070700005)(8676002)(66556008)(91956017)(41300700001)(4326008)(53546011)(66446008)(66946007)(6512007)(76116006)(6506007)(6916009)(2906002)(122000001)(26005)(186003)(2616005)(966005)(478600001)(83380400001)(71200400001)(38100700002)(33656002)(86362001)(36756003)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KToqD05WgRr1wgB7Rln92Nbz6l7IEWPETu+lrcCZ54M41l8xV9ZNEOjZMzQU?=
 =?us-ascii?Q?rR0vG5wX+qv4TuymsvAPmBkGN+6Qf2xhElbYmzID0zh/U4AscNI/iGoidoje?=
 =?us-ascii?Q?ygRgfk9Dv763/ga1u+wF4xpgdmHBBIuAvd/zyYoFrWxYfz3B058bdWvTHC92?=
 =?us-ascii?Q?/3k0/bceyBz+YhiYdn0bhtWBH9t5/rKNouT5VnnD09UU8dG+R++Vvy29SLld?=
 =?us-ascii?Q?cenY+o3Vyqes3LRB43KcOqjrtZa5mHJTplzSJ+fVXOSbHwk9fK82RkEuK0nV?=
 =?us-ascii?Q?mwBnVSiVUjYDaD2ecgU37+veJup4frcQ8OSa6NrtjNpD9WEnwalgVNiQXhpB?=
 =?us-ascii?Q?SlKrzZyjRhaVvVhvZRQA6JTCa4uDA7H87fnmIhBdbOgG2YMIbSHZCo71Hqp8?=
 =?us-ascii?Q?pXv4gII2PmZc2C9i7AYeRZxXCgwXjiK0ivzD8yF0IyhRXD/JSHhCK++EnV4S?=
 =?us-ascii?Q?x4hBb34kiH9Zp98y40ogJ8IOgXb7V1zplx/hvuxMfoPQMU85haX4Wl8Ywse/?=
 =?us-ascii?Q?WMevKNla7T0MihBs/ZRIKjtFdqftxW72ro04V+6iyI6iuDCtuk0GHSCfftbs?=
 =?us-ascii?Q?cFhQaSCyS4tTUIsVqCueeVsYNS5wU5HaG/Y8ZXHIEcWQ26TredwZrkI+Tqie?=
 =?us-ascii?Q?zRNclC0KIJt4vmxgV/Vcc+9mvFrOXcMfsOJFpgcU/Sazhx0SnHLB5lIM9Eh0?=
 =?us-ascii?Q?ouBQZTzHRYmZ0HztexlweeJFn9i6rbMb0KsQFFsC2RyS8qQuAeU+SMtdujYU?=
 =?us-ascii?Q?g/EvgIdkT6rPHqRBU48ZopLvyHBXHltcAmZ+bJ2Z4OIn3Sh+3celnQUEJbEW?=
 =?us-ascii?Q?wXq/VGHonEB8084q9UI+rNYOElEyRpQPtdmdBUVn6Siu/9oyq+GYMKpgG6qM?=
 =?us-ascii?Q?osjNPii6UX6KF7AXTLJJNluTh1sHepsBJuID8kKVFIDueKqVSigmJ4ncFfoj?=
 =?us-ascii?Q?Vj/DEElUrJMhRMMOdJO7af1ntCEItnk9Haxd5jbXLPEl4guN4vzIvf35JMO4?=
 =?us-ascii?Q?vRckzrPTQIQzeQKoDTYnObC2cwpP7HCxLBtUidX7zX3vvwxPcxNhOe3Sq7Iw?=
 =?us-ascii?Q?r+m6Cnmh/BqfzHHz9NF9Fq2FoPbgElKmQSsbrKbJDhXMpasY5f2ohRzpibTK?=
 =?us-ascii?Q?04GirTqY3D3WcNDLNZL5+y44xpmd71qNbYywSCZdoQY/5YJ+vk9fOztsPu5G?=
 =?us-ascii?Q?PlVhl1wbv+7gnWV4E1odP7Z9lItSrnWnXBzSVfoUYTWLGVV4jxUM+dpzXCJp?=
 =?us-ascii?Q?91PZL8medbWoiI+wuY/WLZD3Fbhf0YHcu/ASndoRmDpvabciS/l59pSwZTs0?=
 =?us-ascii?Q?/LBqNc3B/R2dgsZdd1IqhakUHEUHwi7gYBbVyjxIoGs8LVgpYKA9Oz9HJ5BM?=
 =?us-ascii?Q?1ixQBQ9PTpdhFJgeYtrL2kSjt6pDem1cNrwTFJh+UhEa7UaY8r4Ygn8VWkV1?=
 =?us-ascii?Q?aNTfBBCsOEnh7EBZirtveXF9H9uRoFtxTII1C+mGo/M03XMNLBcbqdpOwJe/?=
 =?us-ascii?Q?5UoPBXs2ORRDopMir3Kh3dKEwQufGPV4I7IEF3n5OsSx84GgLnoLvW2I3YFV?=
 =?us-ascii?Q?Vivyq8/8EO7CMKw3PBLM1vJxpgo46UyhK5LfR5a5ak3694VYU7tbiOjZQ+9E?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C14E6EF9859C6049BD4B8ED20B1FB608@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6wz6AcVPtdjif1Ow3op78KIlER2DQw/E5T3KL03ZdhYJWA+/MX3It0Dl4Qgf/wvKbzN+KGA9J9o9t5LwxInY3Bz7zU8mF/Kta4tQkyU6WR6D0wabOLdAI61oj5jffwQ2fb31PHaYD0OYoWNkh7ktCZRJr0VHw+q8i7I+P5ixXewVCU23Djw/Sspk1aA+BowfrqQQv0OJ9LrW2ZotKNNHMPwnr1C49bzQ4/yUX85m7HKbSUu9+L6EOLqqVvpxvfZZnKPfxvsPAAmRYBSG0WIJtCN4BW43rb3O+JGF7JBslXLAXZXdMKzfff/iCJyI0Bq27QuHG5MxIam4nMjXo+9FRRGqj24GDscYQ7tvx2XhHz0eWFGyFxTHG8SHTRahsJXBqRkBKSxzslhgiFZqlDFlR+YHx3gWJzkJGsN9P95FrfS7PJ9AZnce+v3x5n8njWfCySx+DNjKw1zQl27mmsZi7A2U0u6IUIwKLm4Nte2E5rFowssJlBGc8XH6PUOTxQzB+3tOnqjU86MFysVV245T1bsx1AKONssh1khzG/EMMidHQ83Z84aZPxtbrMPHqSsOQIROh6xiFEPqN5g41nrMhmUgiNGA7+XTyr8xflq0TRVQDPn2WvMjbo6maJ7zbxX7fxtiR/mKdVq+DWXuiOSOYvepXojTXZcy7g3VQA88aFxfP/7aMILoBIY4sY5a+m+jv4TiBajlR221bK3vKaiQM2ozTnyJ6KaR3qi1bv9Rb99zsq5HTTA7ccTijg6Ghl0UqZCNfZy8s6mq4tg/xNM7tjdJGFLHouRESlEUHI8yXGldOhi4QcKeOh9p15XqeGaz
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48bcc74-0d21-4cc7-16a8-08db2ca10f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 19:50:46.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12R85Fc26DuQwHSxFhy6/xvaA95WOnI4vMyUWY+hryf6AssQkCLfxpTQXSduJzkIBdmcN5KGu82IZ62PSBI5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=946 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240153
X-Proofpoint-ORIG-GUID: cgja078dQ2LT9S4umGiKyfiOq-pquWbB
X-Proofpoint-GUID: cgja078dQ2LT9S4umGiKyfiOq-pquWbB
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 24, 2023, at 2:35 PM, Steve Dickson <steved@redhat.com> wrote:
>=20
>=20
>=20
> On 3/23/23 2:01 PM, Chuck Lever III wrote:
>>> On Mar 23, 2023, at 1:57 PM, Steve Dickson <steved@redhat.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 3/21/23 7:52 AM, Jeff Layton wrote:
>>>> On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
>>>>> Hi Steve-
>>>>>=20
>>>>> This is server-side support for RPC-with-TLS, to accompany similar
>>>>> support in the Linux NFS client. This implementation can support
>>>>> both the opportunistic use of transport layer security (it will be
>>>>> used if the client cares to) and the required use of transport
>>>>> layer security (the server requires the client to use it to access
>>>>> a particular export).
>>>>>=20
>>>>> Without any other user space componentry, this implementation will
>>>>> be able to handle clients that request the use of RPC-with-TLS. To
>>>>> support security policies that restrict access to exports based on
>>>>> the client's use of TLS, modifications to exportfs and mountd are
>>>>> needed. These can be found here:
>>>>>=20
>>>>> git://git.linux-nfs.org/projects/cel/nfs-utils.git
>>>>>=20
>>>>> They include an update to exports(5) explaining how to use the new
>>>>> "xprtsec=3D" export option.
>>>>>=20
>>>>> The kernel patches, along with the the handshake upcall, are carried
>>>>> in the topic-rpc-with-tls-upcall branch available from:
>>>>>=20
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>>>>=20
>>>>> This was posted under separate cover.
>>>>>=20
>>>>> ---
>>>>>=20
>>>>> Chuck Lever (4):
>>>>>       libexports: Fix whitespace damage in support/nfs/exports.c
>>>>>       exports: Add an xprtsec=3D export option
>>>>>       exportfs: Push xprtsec settings to the kernel
>>>>>       exports.man: Add description of xprtsec=3D to exports(5)
>>>>>=20
>>>>>=20
>>>>>  support/export/cache.c       |  15 ++++++
>>>>>  support/include/nfs/export.h |   6 +++
>>>>>  support/include/nfslib.h     |  14 +++++
>>>>>  support/nfs/exports.c        | 100 ++++++++++++++++++++++++++++++++-=
--
>>>>>  utils/exportfs/exportfs.c    |   1 +
>>>>>  utils/exportfs/exports.man   |  45 +++++++++++++++-
>>>>>  6 files changed, 172 insertions(+), 9 deletions(-)
>>>>>=20
>>>> Nice work, Chuck! This all looks pretty straightforward. I have a
>>>> (minor) concern about potentially blocking nfsd threads for up to 20s =
in
>>>> a handshake, but this seems like a good place to start.
>>> Yes! But Will here be a V2 with the suggested changes?
>> I've done the suggested updates in my private tree already, so I can pos=
t a refresh soon.
> Fair enough.
>>> It would be good to get a new release with these patches
>>> in before the upcoming Bakeathon.
>> The concept and operation of xprtsec=3D is pretty new... would there be =
a problem if all this were to change significantly after community review?
> Not a problem at all! I was just thinking about get the patches into
> Fedora rawhide to get some testing...

To test, rawhide would need to have a ktls-utils package. Jeff and I
have discussed this ... he's volunteered to pull it in when netdev
has finally blessed the kernel/netlink pieces of this stack.

--
Chuck Lever


