Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E217388E8
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jun 2023 17:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFUP0c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jun 2023 11:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjFUP0b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jun 2023 11:26:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463891;
        Wed, 21 Jun 2023 08:26:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDAnfu002447;
        Wed, 21 Jun 2023 15:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DEaOoLy8iGTrc+6OvgjNfoI2otsTi5Yim53ttMiT3fs=;
 b=NRUnANpLx01hldD+7dOxwb0quiyT1MVpxwhJ9qM2/gKhqIJ8/DgcA9FFsmdBElT+TFQm
 bHm/Az8nb3U+djgOGDSTsG3WmDa/xWSbBdYeBSnx2f8JTDr30Up+15aUNOuQrr9GheQC
 iY0T372KO5JqtuT8uuf2kw7f5DU1Lq4p6GQz4sP1FGxgz0hp/EZPzIAC5BVTWaKwVlOI
 7PKd3mcRg6L2vtR35Em00gZrfr4CcqtYN95xLqxYGcmGf6GKWkPQwL4ZJCr/JM4j8lzs
 oOR5E1VvqG9SAI7poxfVlahFdDKHFPKCKT5WDxIAE5JIBMDfzQJVXqZ6NJ0H2ZR86q/K pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3qwan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 15:26:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LEKGxh005819;
        Wed, 21 Jun 2023 15:26:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9395ye5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 15:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIBQ+XX+uQXbj8TYju74dvNGwFbs8YXoQWizzQPe2JZGjhlqclM8rtJK/IXs/JOck0wm9Re0P0dSjRvfe6t0UKwMEEjq1hzvGnFtEY4v/N4u0bI8uq/tZRU74Ss7ZVvc/815QPXA8l0xbe/Yt3gDcw4uokh+HON8agldqAbCDOgcBUNx34DzV1WnQuzpRTp12yg2u5wel8DVigG4rPa5g2aQby4OQHW8paBaxYzqcuBXBOtNnL6mKDsAbFpQPVGI7I0rOHoHLvRWJRuQSTFmBmZePxjZO+23yTwULAURj462U2fk2RWhOHxKRFP8i3vWugb8o95Tgk5bH1Me/d7mhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEaOoLy8iGTrc+6OvgjNfoI2otsTi5Yim53ttMiT3fs=;
 b=dV3jIgr1/GUje3gUs+7YjooXOWYBeeix0gmsOL+KSKM/Cua7zRJSHn4ckJx+xxYT4tLWMitBzboF6NJ6fsvguODpUaYXrxKvE6BGy6Xy2fI384f5Qu10pOfPF8qwbNzYrUssm26w9OrVKBC6z+hfN262wO7iosxqeEvP9H3GdIlcq2uPe+VNYIjdw1SNgf8T0eEEm4+agI6IdDM1iK+3sBaWU1v3vLqm+t3YHvERvz+wwoOx6+rybjXi+XgYfy1WVfjAmkLA7M+rVs1Dwq4HfNVFPREN75Y/FQJ46M9W86tycA1Ek26JEYL8EbfpbfaQSLvRmjMedvVcXNFXc3+K8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEaOoLy8iGTrc+6OvgjNfoI2otsTi5Yim53ttMiT3fs=;
 b=HgVe+iVruRbg2+YH7HuFzZPZtV3j6QSqSryyJfv9+KGcZKfNepKZvHZWxQk8xpSnVTtoeJRG85SwwHi3lSm4+h/5+kUNAL0AjH/pEdLmECeQbQ7+lAiF/VIWYqb4xeutx16pkdekLLVs04PPvlMVWfCyHaekd3gMpyNkf2lHVCA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7091.namprd10.prod.outlook.com (2603:10b6:8:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 15:26:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 15:26:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tejun Heo <tj@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: contention on pwq->pool->lock under heavy NFS workload
Thread-Topic: contention on pwq->pool->lock under heavy NFS workload
Thread-Index: AQHZpFS8u3GiMvOyOE6KS73MPu0Bsg==
Date:   Wed, 21 Jun 2023 15:26:22 +0000
Message-ID: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7091:EE_
x-ms-office365-filtering-correlation-id: c19418ab-e591-4ecf-16f1-08db726bded1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2VEStpBLAXQetLVRbYnUgD1GP3OKTaKFYjitXjTXrgpEHqC6psEVvY5HhMhtLOK4O3Ym/401W/uQJkvtmyn0o2lwhCbhZaAgWi6D68cXmFw4mk5SvQOks8wWBxWh6N9HQbW814/S7gKzHaDBF10hpa1JJNRCWjRUe0gVthfgpgYyoWa84u4RmC0TsrWIK7vXUZ2Qyg8KxsEpcWFG3NGmu2eXMwD+C9gHQao1NXiXRBqOD+p1OSo3iMAaMMWu+mIs4nvkIqLwpejKyhA2oCt44gt13jlxlklR2qGL/qix263NaFLnKIo6or24GwOoViJHSFfXCuJLnNSg7YnayyHtL4k1jrStzVDHWAXU4ayvUrBGEGuf7BPRTnNg8UcF8Nhson3XUyod06a860X5M36Bxd3Kp9S8QgoZ7Kc67NIwQQSYOQoWSIYde3ZyxgY2ICaizxJm6k0Lhrw9EulfEfQldAyN9ALtpJVIateA0l58pw+BK6C0doFmasAt+ivxwminFD54I3qtoARDC+bsXyfjdcdOJZVBjUUboStgmA6PHSyq97LAtV74kimG/9mFFgGFyyQHeOeEbaOQczGfTZJ1XjFIxybGBtNlnFQiyzzaUDVEu+OR2iuPvIdKDXQqtUWKDSPgXtdzn8kT1JlCqB3yrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(33656002)(86362001)(38070700005)(8936002)(5660300002)(66476007)(316002)(64756008)(66946007)(8676002)(66556008)(66446008)(6916009)(2616005)(38100700002)(83380400001)(122000001)(186003)(6506007)(6512007)(26005)(6486002)(71200400001)(76116006)(91956017)(478600001)(4326008)(54906003)(2906002)(4744005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D9RkrKoGvgialNFNS6tJMMATP0V4G8cyPZcgFN+kXwx2OEV/NpnYNMnLoLX3?=
 =?us-ascii?Q?xUhNpHcPhIE5K98vSCruVk+QfUAaYx6eNFipl/aR8YnFp3I7GSDn5BffAkFA?=
 =?us-ascii?Q?r5Sxr+T3nWX46y+qaNl06CliZQQXhTctR3/tsXO/Ec1keXkiOGNijLq60RSl?=
 =?us-ascii?Q?6VX+hwznDLquJLd3iC4qY4LIO6HvFYTgTWUPg5/wO2Xi8yEVAnKClqIQufmC?=
 =?us-ascii?Q?pItncm9n66cpbLKHPvU+q9eZETfAY52TZ8WTmtQFnJCRjAqHm2sLxeUQlBty?=
 =?us-ascii?Q?n2djVVdgIx8c3Zjr5wxphwAumVK2TM7OT+xpXgoDlEDZJ8O518Cho3WvWLZp?=
 =?us-ascii?Q?Xk2ZhTblgqbMOpV+FFokfzRyUBd1hwsO5KGVPFtnkJsWVy9VCrZFktfNmA6g?=
 =?us-ascii?Q?ZnkEik3DxpjgWnh990vu9bXH6tH485cXFOeBmUF1b7f8UhpAzFq8Qx1GirqE?=
 =?us-ascii?Q?ggelK+4ItogOF4GMVISV3CvTSxcMu/aHh7pK5xEgIG3rQd8LU+PDSoBP+1pp?=
 =?us-ascii?Q?gU+JhI5SDKfHPIpe1+eXr/4BEQrffpbq0vcmSKVo1M07ZgOF7ajOfDzmqZe9?=
 =?us-ascii?Q?KywqPD6/cnNl1mvaFFwNr1WZxy+tWKl99Ns8V3j287NTSykbf97Bs9EBNPML?=
 =?us-ascii?Q?Wqp6ccGrqYX+INX1SR1u9GuaEX3oKj/FqhkOMwnVDZSzoi5U6M2nbb7zjHcd?=
 =?us-ascii?Q?xBAu3ood8z+vPIt4B8GIYVavjol+MrYd+tp7lxTL9R/YTKPbPRt19csrtpwt?=
 =?us-ascii?Q?q3O0CQwW2c9NGpokrXB0DM59NVyYDpzRyRIvwGwr+DgYSuWcQ+Xi+UI3fFDy?=
 =?us-ascii?Q?dvxyBcLWqbvD7sc9Pxnv3Vakep/wbJm7bg6S/1ymNJ3NKS5CKCkC6+7QgE+W?=
 =?us-ascii?Q?HEaYpGg/9R8hURrxkONowdmkF0p/q7AqVeFCZPTHeN60/98NhHuVsjLEXBct?=
 =?us-ascii?Q?gxpDAozc6g8lMN0VU85EeCvDSvSObPWQazBrV7Oh23jJKQ8I0g/np+A9q6oa?=
 =?us-ascii?Q?FUw/d/dGpG5GXDdVW2aB+Z50o7GDZm1m9oIBzQ9ldj7ycerLIauOotIcaRmI?=
 =?us-ascii?Q?DaMOcfs2s9oOyL8MDScS0yn1O2IYlpFnE2uyLvLDkVckXXkA1RR3ER/Y3ZK+?=
 =?us-ascii?Q?lw9jEnCFogGZvbhpIbOgKWvlfnRQOMniHuVpi8zTLr2sh6U/TxfoPvcjEeRe?=
 =?us-ascii?Q?gljSV1xzTi6rzIy/7trBiuK9HYAtRKsPtNCS1rvPjaW7HwRzWBD0qRecxR0t?=
 =?us-ascii?Q?vSWTodvoqsnf9BoZ/tuN0U9TbBAfinB6lfztx7ir0CEFHYWkJNDUCGRDB7E9?=
 =?us-ascii?Q?HZEhDGpX/w8vfKc8oDq0CYdbLg/8wOMMcvqjqC9lzNrljrBTRRxoR2UlsioS?=
 =?us-ascii?Q?U9br5s9r6P4BV1b5+xsQ6Zithv2uaCj+ULbvRctC2w/C5iaBUXg6IAuK5IUm?=
 =?us-ascii?Q?7jUWZQByvkeC1pu6qYlHGncmv2ruu2dQe3uiZa3TVisHEgYK9gS3O2twxzLN?=
 =?us-ascii?Q?w3KjF8EJWgMNgD+VTpYVEd7FBq+zEiQ59YAi+1x+Y2D6hN6XZ/THsRgLcPG1?=
 =?us-ascii?Q?/eXdExrH7N6XL7sCHN3IJK1+nGeNv+3UYhZKNDpECIrEaKZKuH3UU6HK0VeU?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA6BCD8C993CAF4CB41732DB7CF3097F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r3s3BRA3xQGqxqxUly17Zv90xgraUHpbGzh4qcwRnxb/hiK/uzA+xE+jIK28YXw3SK/NAuYhmoAU8PPP/+xaq1cMlvu/vcxqkEV+sIKWzvJ1BnXZSzGEMSMXE6+OoESWd2nocGYDeyB9P2KeBOg2CS+TP6uA7VAmO2m7lhAT5Q6CD54oAuEk8OLL5x4r7Itvp8978cSr0d8b5watp1PS2G5fw9H8nwYPxuXl2O56QpXl2CrQWZRv7FNy0RcSHQywQq26Ks/A2XrlAW7TkPVQ+TlRz/0xOglmBVe2BT4psrSiaQIxaqhQucQq7Bqp+R/k4yv1HEqy1MAHhzZxitL2C/Cz5sc33InMdFXvjpZWcmJl7iQdPPZr47m6GtdVJlup9DCUv2MlF/cviXBr1wScLZcojgN0hsqB6Vl5w2gtP3Z3IlzXgw73unKHXcyVUh3N87z/3yF/0RRAWNA7JpF7CLtJsST9WfmLZgs/MYJiWB14w79nRkzguSDdGzhu1/V/ZeLCicARlUfwPB/Pb4CaPAkzxAx1lS7AFG7VHvnCLxnBVs7c/NmU/xpYtj53xfo22QyE6K0RjGmQvMqJGPqcb9Ja/0EA4L8kjwT1m3aKXoILLqr/6RuNSohy5wQ8cbMELnANlRzYCNbpgtTQV65qXdm1td7LvGY1ONIVYDT5rn7XMIkfJqsYBrAfPCs9EToTzq9cMSh4Uj7NHHAOaPHDF2V6HAMu5+4aa5z9Fy5mXhs/hfHYxI7MZFLjCT95gDEKqEFFtQ9ULp63YJOBw5KzQzQ/jv3YG3mbOR54XnnPMbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19418ab-e591-4ecf-16f1-08db726bded1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 15:26:22.8264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uP9PE7xljy4E0jfdPTfqJwsaYdrGDqSuyYe4ZaoQewN3mu0AwwzjvQUsyRpTz7Fl7MXOb/r/WzsskXwM+JxlbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210130
X-Proofpoint-GUID: VSEmmlUbNBr8rDTZtMkx0kyvku4sH7Mg
X-Proofpoint-ORIG-GUID: VSEmmlUbNBr8rDTZtMkx0kyvku4sH7Mg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tejun-

lock_stat reports that the pool->lock kernel/workqueue.c:1483 is the highes=
t
contended lock on my test NFS client. The issue appears to be that the thre=
e
NFS-related workqueues, rpciod_workqueue, xprtiod_workqueue, and nfsiod all
get placed in the same worker_pool, so they have to fight over one pool loc=
k.

I notice that ib_comp_wq is allocated with the same flags, but I don't see
significant contention there, and a trace_printk in __queue_work shows that
work items queued on that WQ seem to alternate between at least two differe=
nt
worker_pools.

Is there a preferred way to ensure the NFS WQs get spread a little more fai=
rly
amongst the worker_pools?

Thanks in advance.

--
Chuck Lever


