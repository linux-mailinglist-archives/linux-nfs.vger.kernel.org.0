Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDD7DA168
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjJ0TlD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0TlC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 15:41:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69611A5;
        Fri, 27 Oct 2023 12:40:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUr6r003793;
        Fri, 27 Oct 2023 19:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aqRn8FQpEUvyu8ROgQ2X0Q11ogiVbECYTyDUzTrjsUM=;
 b=s6Tu4Xu/hw6r5Cgri/gi0upVp42hBsEEb+9eglTCR1Lq84gCk9TeIJZbCXLpWPp648bf
 3goCH84DedA9t3LDE4jwfBfDFL9rIIzue3nlIjKXNMDYzeujmVCMOxyMlaGQQV5dHct7
 keG2quVZ1abMe3yD2DzkqlPXkdpGbicasWp4V0WhVEus82SfIURyE+fJqOutUf0nOWIL
 Qj+C3xB8mdjuV5YttSnuwzs7wPtLcoZeo9/bbZcKyzjVsnF/BzC6Q6+ps4Z2aR6qSW5x
 kvY8onsemsWFS0XhnXukChAd5A6a2PtiiRwd2omLzXL8Ole8zXBqMmKI55BEEufqPV68 iQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywtbabjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 19:40:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RJZE5m019886;
        Fri, 27 Oct 2023 19:40:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqkn0vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 19:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5G44TkmsXMk6aE3FRx6EcIDLj0X9I1wDZ2nEZ9oJ38iy+P/24dcBbj9qr1Z+jNMh4/kBNzd426q2dwyN3HeHEJkWBoSDiWWct0J1l2f1QDXMjEMCZqeAiD91qJCN+cocoony/L5UJnN7b4E9pqzYblSUQzuMPisAMKb0o5Y7hv3khgm3qhEaN9zxmQdxaol4eNVkfFziLPOwe9HSlmUsC/TJtCGesxXNU65FWtcUDJloqZoeAHewovG3ud2YYaDTQfjpcZ8CvF9z9L0gr3dfXQFdcABmyoyo+83367aPnzvWGruVTulwLw0i7WuutbZih7vzXAcefMfHzq7F/J5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqRn8FQpEUvyu8ROgQ2X0Q11ogiVbECYTyDUzTrjsUM=;
 b=BCAjq/sS0EIg2yR96mDtKbbwJYy3jmR7Q80V1Z0MS0wTI+WOJRqfRE27VLfulVvcqROGhNmIa+coYqEYPFBSe7chNRkemFxk3zyUkco5y3JTVQ75HOzfbT0BGdqQyuWSrHDBUi6QIm80uXtMgFQ/q+r/PY0cap7ILR+2KJp86gYgIiPasBs69yDvrv2Ll+UsloQ3vq/OzfyHRlLa6o/6PPdbJzxyjnXJZB5g/RUvNm/tCBI8cqtMJZocAnvNVmZbE2Ilxkhufs4zV6kN66B9YAyHnCFVSb/BwRha0WribgRIGdio3KyDzvN5YC0usB9t0TwH2o9M6V9V9VZJrcDWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqRn8FQpEUvyu8ROgQ2X0Q11ogiVbECYTyDUzTrjsUM=;
 b=SFQZTLI3XdrOmGjZFfMBAwUno/FJrDERTI8qOWnoRCwqkvduBffMoHYnFkMrUHYG9QrD+XxVPVSOT8Cy6Z6Cy9Y+7rS2bj4k9x/1yX5kJK3HqKnVxh4RazzJ3ckTKTdOEuIIpoZsJEInl6gWUjMLL041G+3Q2rdVKKNKIpZc9w4=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH7PR10MB6460.namprd10.prod.outlook.com (2603:10b6:510:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 19:40:36 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 19:40:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd_copy_write_verifier: use read_seqbegin() rather than
 read_seqbegin_or_lock()
Thread-Topic: [PATCH] nfsd_copy_write_verifier: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Thread-Index: AQHaCBvpT1YyJkmg50Gbg8cXyhTQ77Bdyw2AgAA9zACAAAHLgA==
Date:   Fri, 27 Oct 2023 19:40:35 +0000
Message-ID: <8FAB33A8-CB9F-41EB-8CD5-B558B993E912@oracle.com>
References: <20231025163006.GA8279@redhat.com>
 <20231026145018.GA19598@redhat.com> <ZTvc0Z6DJEYXI/TL@tissot.1015granger.net>
 <20231027193359.GB24128@redhat.com>
In-Reply-To: <20231027193359.GB24128@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|PH7PR10MB6460:EE_
x-ms-office365-filtering-correlation-id: 11f8bff2-c099-4025-d0cc-08dbd7249740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8NsyDiEqk8WT58lG2lAFZ2dYsUjyn2x4uh6G2Jzo+CUFkldb0Wvbi9hZAyoWGxtxKn8AUvuM2nw+ReYZvMOex5FFwcNfXJL8S0/UoS6KQmez4M4EGz/HmSMQaMP72CO84yqBhhqnddektDJX9Ie1LBPFHLbUduAbNK9N+m3c+PIMz6o3qJwcN900yukQHIxKBN7vWlxBh9yPqWtMRa9snXdVx0QOYzhPVgTUHL+4PPLZkAC+FUq2aOlbIcQlyZB/pjv7KPkILp/0R5Z2tFC0foJGTiRLdQZTJ7IS1yx9n55iceaDjgzsZJkxTZO6IXSk6PrDAn40kqUEKEBQHeuWOFnYy8FZ8kATat2CZgo+VS6ImAjKUQ18DCENi9PjwyFSOeOqAargahCZ61x4shlAYXnTvdU8TqWwq4KppXtKhYjTulowkHz8QVJeFlkzqqhX4xerUqL0hEeNPzvKfOUao6aquyvtDHuISdB2obTzVfaQHQOd2sbJE1ZJFQ7IRGCoD753sOgCGtVvh35VcxPK1t4IHKnrs5XMKROfHmalv19/1GuYOnJOzn25UnNH1jcBAbUob1DRW1vdTNHicGLarWVfh6egvsa3MeJk/i/fXTgTrG3sgamoc8two4NXyoG1dE6rgjRai1/WqpZP6H4pA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38070700009)(26005)(91956017)(38100700002)(5660300002)(36756003)(2906002)(41300700001)(86362001)(316002)(8936002)(4326008)(33656002)(8676002)(122000001)(478600001)(53546011)(71200400001)(76116006)(66446008)(66476007)(2616005)(6506007)(54906003)(64756008)(66946007)(66556008)(6916009)(83380400001)(6486002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ELW3XIjC5V5DWUI6Gyg+cwKmsAV/d5pqy4Do8LUDXlw/FkOrikp6mngLLHYe?=
 =?us-ascii?Q?HQf05bULWEsHwKuuIXLIvEaxr5cWKMibib/c90HW9ca8tktx8ZvITOUC3ayR?=
 =?us-ascii?Q?0rq0c0d+wH4pQzXef+hYvcEvDQU+RqqmXSD7qXWl3cHeQ2N2nKF8kmKonsrX?=
 =?us-ascii?Q?DLMiPbj4E4sxeRjr75AJCFyRPiqkVTMcpdFpUgzSLgg/8jMiwcKTi/+KYpAj?=
 =?us-ascii?Q?BVV7kmPifQqkEeO2lLkZ4mCszM9K1cMr8NQdg94L5cg2Co8rxM8PZOefIlg7?=
 =?us-ascii?Q?M99pi+wNYK87mAVN11RjxPv78NngGdJyBsRDU/9ynsXBFTAcLhg2FjKO1JTv?=
 =?us-ascii?Q?zU0aoomMb42sN3/fJb+T5Dz2wH1On57Y+ajtWWe0hfWr6w8aVGPIvkt3C1D2?=
 =?us-ascii?Q?4sumomnqXQ75RnxMm8pIut0NlrX1qvt+SKzwxNcrbWsvy+RtMx4GtclmDHDs?=
 =?us-ascii?Q?+o1nUFUCf4kfDfQDqlThJPZLachjf1WXeeepBthrarinc6F28xe1aR1xCMyO?=
 =?us-ascii?Q?F+ATQxZMr5GEADqrfGLhjTzQA8QZgag9rsWQ94MI/2/6UPurfSXKknnIcnk5?=
 =?us-ascii?Q?Lsc+zgML7FcTFjCMTsjhrJ4xnCZOGya9aXSqa5ekysA7WnrmKfu8VzUk0pfk?=
 =?us-ascii?Q?zvAFbyNW8gOD6ry3/V4ohUOrVeHylvBVL5JeFfwRcWjmivj8tp1XpXYVQdYN?=
 =?us-ascii?Q?IH8B2LxBjgvmzZ9uJ55JDPI6mHxYzs7Y1FESxB+yGlx9oAxjCeXiHWwkZBja?=
 =?us-ascii?Q?66QMmKpSxUDwdRKTH/uEzSZ2KOjDLQLTWBjc2R6WEC5R9kmxhq4d9M2HLcLC?=
 =?us-ascii?Q?8O4jgEwCN9yMTSxVBovZVXHUhPA5i8djoBLjwan87J5b2OhmKloa1+yWTwt4?=
 =?us-ascii?Q?+MlCZy5rQz4gJvpTb91Ml5TiZvRbao/nAaR3+sNsq4sMf12Xbreg1b1j6fbc?=
 =?us-ascii?Q?3nqOkb3LhxMCa6St7n4sjAIy6CHL38UM2JKC91iQ2TcPAiQED/JDfLy4HbGI?=
 =?us-ascii?Q?9lmd/Xj0B85QKsnR8f4cDqo/Bshriv44C/8hZ0xGbC4Wxb3GlFygfXxGJ9UK?=
 =?us-ascii?Q?lLVXLg5dyYmsp1jdomGUrMBGxludFyN5wO0asuh2G3RwrtOMMGV7YJhOccS+?=
 =?us-ascii?Q?srro2udXjYamOyfkRivJMgOhcL4Vw3l2VJNhoJ6HrhlyIhHELBgr5yaEd/AN?=
 =?us-ascii?Q?BYSulEnctKZzeo085X2ccrinAiTpMQrLeL3Pgh4Nrh8YuhTczkePBQUuAHDn?=
 =?us-ascii?Q?q/7guJPldzvunYmjpb2GxtNyIwZzCIR5yMPRW47x8ez+r2ZXXzis2mjyxS4y?=
 =?us-ascii?Q?/TcSqTzXBq8uP/SX5GW1CKcLWRJsFo4/I+6oLetInq1xdI8YD27EmD3WMVet?=
 =?us-ascii?Q?kjYcf7SQJGEIfm9AwgvhVp9JSNCgcM838ZPtHA5zcqkRUGwVD9HZgnI/9h07?=
 =?us-ascii?Q?SxsZ3TTxpACfT8JW/rMbNoJJyOmsBQVW6BPcVvcgPKo1npHQ8l2R4B4gZXtr?=
 =?us-ascii?Q?4wBBu6T6WWuUmK7BRIWDd8552RnhGyUF6CIJmukUGJgums4yJXVbz7cUiErE?=
 =?us-ascii?Q?H+3s4pa99zdRsVsv/G60eo2Pd4tpPTwm7ddmUMBwRUlqWrORFlZc9Okxqigf?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35F9FC619519594FBA78A3FB72E7D6E5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UGP0JXPmNQLIRLs/HR1x6aFs7HUs3UAKZbGIsgdWYRNK8B6T5HvDNie4FaQrBqh/37r4Y4YYxdvRgNdxVydkxb45htHUlvjMZAYHu3yjDLTUh708lOWzxyksJq7WHRaoXgr30SmJ7+LmlH0QYevJ3djCqk1I5qd7vi8RsAFrTB6FlyLfs+x4sXuiJ4XHBN2ilsqTrqtxo710qG543buE9zKhRxWjPCOQbypUNnVdAkfVzYzCyxq7dpEYzUXMSfVWyVOmyJlwAFFHuLFdQIxUXBYlOWttGn9DeMJrmGmMtkfprgZWLCxKBmfT3LJHoSw2acsStSxsxYsymHmCdKBXA7WlNCCNBt0+Pgg08j83AZA/uIr8c45HTpK+ZGSiRVJYkuiPpYpyv8KAtonmoi2kZy8N5C78sixPJ6GQceYKYGhHOirF3CcSsrWvZFOX6YM9hdstBoJhDmIRJtve8I7P706WEJ7yompwmxtaxXcVEY+HKqRe8AlngvxiFq99Me0Ae8Ds8L09VclTLdB4zKDVhOfETQyLkS8uGRAkp+UFDZstDTvExbhS0LDWL6uk7wnkocZVVaNWSUMKH/KNkm4xkeU02aNY33kxc1NZ0aUK6r5RN5HzXckF5RtpsfnFA73Qa7ncnKAJLMh8EYMuTlOrET4z8hnIhqqoOnallzvdBXUHi2wW1MxJ9CjO81is3ie0FkWhR9wQdtDl7LjFcMswzI3buLip4K0cpwA3P7l9nAcERQgjZRWA/uihtpkfKVauueQPg3w7WoGPRtIKSE7EzHjR1wUGAqO3l5BPOJ2rOIxzenfZ7qO+F7kztBs8tXAj7e4i73uhYy0SddVq/lBGvHjyjOfKJmcc6b9vkf2U40rBKdQWk9vZ3IBQ+sf/2IAXYVKL+YjWKvMRUyy7EQ811A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f8bff2-c099-4025-d0cc-08dbd7249740
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 19:40:35.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KoIbow2A+1snWaLSsg9Kc2cpmapwCLYFWEwPLmH4Ps+GZV2wa1nC5trIPYolAFyTDYTx/E1v4L01vEH+9DIQOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_18,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=987 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270170
X-Proofpoint-ORIG-GUID: QbtPrnWQrTsgg6fvJK0GZITBrsQL7TgH
X-Proofpoint-GUID: QbtPrnWQrTsgg6fvJK0GZITBrsQL7TgH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 27, 2023, at 12:34 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 10/27, Chuck Lever wrote:
>>=20
>> On Thu, Oct 26, 2023 at 04:50:18PM +0200, Oleg Nesterov wrote:
>>> The usage of read_seqbegin_or_lock() in nfsd_copy_write_verifier()
>>> is wrong. "seq" is always even and thus "or_lock" has no effect,
>>> this code can never take ->writeverf_lock for writing.
>>>=20
>>> I guess this is fine, nfsd_copy_write_verifier() just copies 8 bytes
>>> and nfsd_reset_write_verifier() is supposed to be very rare operation
>>> so we do not need the adaptive locking in this case.
>>>=20
>>> Yet the code looks wrong and sub-optimal, it can use read_seqbegin()
>>> without changing the behaviour.
>>=20
>> I was debating whether to add Fixes/Cc-stable, but if the behavior
>> doesn't change, this doesn't need a backport.
>=20
> Yes, yes, sorry for confusion. This code is not buggy. Just a) it looks
> confusing because read_seqbegin_or_lock() doesn't do what it is supposed
> to do, and b) I am going to change the semantics of done_seqretry() to
> enforce the locking on the 2nd pass.
>=20
> Chuck, I can reword the changelog to make it more clear and send V2 if
> you think this makes sense.

No confusion, the changelog is clear to me. I'm simply stating
my intention for other reviewers and the lore archive that I
will leave off Fixes/Cc-stable when I commit your patch.

So far there has been no review comment that suggests we need a v2.


--
Chuck Lever


