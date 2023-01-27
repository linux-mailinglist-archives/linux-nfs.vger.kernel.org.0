Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9B67E95D
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 16:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjA0PVv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 10:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjA0PVt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 10:21:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1257D6E7
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 07:21:47 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RESguW022416;
        Fri, 27 Jan 2023 15:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=L6OG4Wo38H71fNVZCafRwTHjxe5UpwZC5FqQvHo5aPU=;
 b=fk8clD2HftXPgF4x+EslWQhlNVbW7VtYgwn6cCryiSV1vabkwW3Nf4usTBZkV8PAiqU5
 A4Ijq5ON/vob91AhmRxORMBucjvebWWxm0EPE3wO5KSa4HeYI8+ia4Prka0PiWc9B/Sr
 8RFZ0lbL+vf+WAOo+LJ37A+tA0zL4xeyHMeC43uYg8saDtOvTiGYj7LDkILKdBhvAoFQ
 cMy+s9m8LJ/3yW114zaSZBKAp2Kh3qxv2Qttot7qpWI7Z0tGLI9JF7e4+liP7+3a/TVJ
 P4MT9F2wNnlnhlMGnlU1Hwr9yXKjjRQxgdphStp39Pc2vPL9RC3rLC0MTE/zqpxoqz3W lQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87ntd01j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 15:21:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30RE0RlS006176;
        Fri, 27 Jan 2023 15:21:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gg6ges-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 15:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8eCs7aODCUFq0G86cBRY1iPkWw+VaY38SAJ5nPG1nZZ1Sb98mKSWtbVdGmDfDfVfcjTHLVFZwYg0CJLaJM7f0TMb+GQnHZg6FDvMjVipkFxWEfzWCckhnX1Wg7lByK3AqpkpcTiM4nTy3MQHfqPPNmsIpfM6wVeyh9RLyrTHPnitALmYhPcZEoDwJW0fFEF1RuTt3Ac7ZBOR4vGpt+nR49IKTqBSWNHe6Yc/xNgTY+xpDdLmJiEvUY8LCzeItjwxUCF/IH/kidV9fUiLyX7Hw0Q3BYT9yJDnbk6w6wTEA3sRN3ZGvosOA/Y/G5QEbfg/CWt49nLWXw8X4MSE5lg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6OG4Wo38H71fNVZCafRwTHjxe5UpwZC5FqQvHo5aPU=;
 b=Ci3jquczyjmVPwTKz6Nyu6UJbZnWf7x7txkuh+9XTNXl/20VHjSumDrfFcGekIr74jFylIi2aHZUXo491cSjSRzs/EK+pd9MQzekBK0vyYkZ6jO10IiFrhBzrEqFXGvZcEhoMoM026DahIczxMU8YB9vGLrIN8SMyOyK1BYQ+w/fHSlUsJ6gsa1/yS4YCi0COXsHDHr4scICJJzRnE8tBSarB45cLgLpuUcCUTy4KGGA8nVssnM88V5NDLKk0iDtFWDSaILvI18yo3SWQMWhfQbOmuApX+b59EsTLC3lXZDH4tElcej7pNhcqlTk3ILbMzrDMf6RdalAcBEGWLNNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6OG4Wo38H71fNVZCafRwTHjxe5UpwZC5FqQvHo5aPU=;
 b=DFr5ZI80CQ2nAuNa+DwEjBpzUb1K4NCImdfZ4V+LYeS7qlxbfPFUkXA610aQ0K5mLEmrlk/Lsw7Bp3S1jS3AtvxM/xtPKCAzKMtm4D1R5M6aqAf8H1FkZzkg07NkzcRQgcgiAufzC4HyVrypIV3KVA9xPD9Kdkd3ADYzopx/5ak=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5596.namprd10.prod.outlook.com (2603:10b6:510:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Fri, 27 Jan
 2023 15:21:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.013; Fri, 27 Jan 2023
 15:21:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Subject: Re: [PATCH] nfsd: don't hand out delegation on setuid files being
 opened for write
Thread-Topic: [PATCH] nfsd: don't hand out delegation on setuid files being
 opened for write
Thread-Index: AQHZMkg9QowbIAXTEkyy+4RjwAMvNa6yYYqA
Date:   Fri, 27 Jan 2023 15:21:40 +0000
Message-ID: <D439961A-3E64-425F-8385-E5179325576C@oracle.com>
References: <20230127120933.7056-1-jlayton@kernel.org>
In-Reply-To: <20230127120933.7056-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5596:EE_
x-ms-office365-filtering-correlation-id: 599480ed-af9e-43ea-a880-08db007a30bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wv9UsC43d+KNbCXlAP917M9Gimk8vdSAu5Kvs3b5DTeOEklY40z84C/Kw2qyfSZN0YDOTIuwZJbCTazINk8RG/gZu1eiFRBvoLlt8OxPr2CHWIRWwrj+H7SfN7DoT87VNEn4arFl9uK8MwERFkILaGkU8CG/9mkZQMNicluWHrGulQbuzXL17qhtJNOUYkL1aKhlA3ROY96pe0zNo00nsHFZwu8ecNLh1OeV27Fi1pQBUq99h0JunSNIOwsbOag2CvsSap85UXXAjPst36v3NvfWy3QT3L6jrLLaKQWx5bYPKjw7k4dkK30SL3I05Es53mK0cwSMKVMnzKrkJ1oQHyUf9m30ulCqe7nPQCx6jSb67z57MZFKlim5dDXCdsRoA02S0DbdQQxKJjhIUGBvipaJskw7/78rOF6ODZDsCObN9NPQzXeRXOkVC+imSloRxeO674q5071RBm65KtOEWbvu+j6b7FPr3mTtV9V1D1vyTskcrVVpVO8IJtSCIiGqQ8W8Q2xSnmJ7aJLkSttCyw9FeBiAy3ENnPqSQqbBoOZ8fwmdYbNrxWWY85mSwrApUN0Y9A/Y8kSZtccOyX8OIkLGh58KgdLoY/7cbroluwbSNH6TNTI/g18phgG67WbBtgDB+7uW0VakXf9kd/zrZp9xx/F0F2WQEh5lhBsink2qxVZ+xikJSRjdMTE2BZxdUk0+0/xdVmhxy5DMSm4lrkkpwNH6Y2Uxl1wMi2RgtnA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199018)(6486002)(5660300002)(8936002)(478600001)(36756003)(41300700001)(83380400001)(33656002)(38100700002)(6506007)(2616005)(26005)(6512007)(76116006)(86362001)(71200400001)(53546011)(38070700005)(66556008)(66476007)(64756008)(4326008)(6916009)(66446008)(8676002)(66946007)(186003)(2906002)(54906003)(316002)(122000001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8UthYbptQgnuTTorHc7GDqdBf+6MhMGjR/4p3F6hfvurDtIwl2nb5Z2p7nM/?=
 =?us-ascii?Q?X+2a902qaDcJLnMqe6Ke6ReVgtJ7l+OL2APlki9Z8s4C1/a8at4m4RBo0WFB?=
 =?us-ascii?Q?aWhPNKDzdOudYsHcU/xKUZi9BsHQiuFYKszErFwtrnaAAs7YBn2+47t2sGdJ?=
 =?us-ascii?Q?WUBsrITrsJkO8J39viEl1zUcCzmfdDrB9osoycGpeppkmm1UKvO6UQ5gtmMW?=
 =?us-ascii?Q?hF2xL/olR7oD7QYH3uvq/79RW9NP/RJF1ukbZeDosCy5qZ9+waSf16ZomU4S?=
 =?us-ascii?Q?DzI/M+PUjxRgCHtj3HBB/7wSJ03ZGRfM4/lNwzY4oD3MZA1J6V3n8b+PE5kI?=
 =?us-ascii?Q?KVvYfG7ZH7/fuTKgy9SW33n00hO0d4Et0UDi6+EOJYUWkZgAm8efieXOyM/3?=
 =?us-ascii?Q?tufySeUi7g4XKZWkTN9kCMFkG/4OyxTbcZuWY7tc+ycVbpm4GBJ5MYQLRGc3?=
 =?us-ascii?Q?XnlGimEPuAXtrUj14uMuBuv1ShvRF6k/DvtqtnC6NongDz33xp5Q8uPfLUc7?=
 =?us-ascii?Q?Zgyd0NJ1XUPPK4x1MrRRtxbWEJ3j9vuY2iMgrybr643VIEnm1wViYHHsomEy?=
 =?us-ascii?Q?iG9s4WkFs6huAx2/tDAp5kndbCVk81UleoH8uGgLvIMXWcJSnMTrc/v/dWVI?=
 =?us-ascii?Q?O1y3k1A9Olns6Qzt7b0MzF1EsipZLIY8qMhTwuOGayPG7V5v0quVdcFEDs5Y?=
 =?us-ascii?Q?MeJ36+u7SC1Nm0CthsXusN8I+SQDQKKGeJr2HKKS18lMAAFhKaEskCNYd5Tk?=
 =?us-ascii?Q?5xO9F19t2hnaK1gmTmUVSI8KpXtYZGT9aaTUqONI8PleneaddDB2hCxPEqbV?=
 =?us-ascii?Q?uvOkBAOBC1iIo0zKfeVGDst9mL10TRoIWFMLpl/4ODIGbZ9N+mKaXeQxFgJk?=
 =?us-ascii?Q?u7QoOTHg4Wofzv8jP74UK2hz+PS/3aBK3YO4daBA5M+HUhh8JyYzIyyRXCV7?=
 =?us-ascii?Q?SQ+0VVxEZBeCF7Rm8hdTXKHprgb90OG73JzUzFozXu74sgOK6kX4FRthyVrn?=
 =?us-ascii?Q?kKCyBF2wsJXP+sPwk8tr69afcf3OVsMM2+BvDzJ9fkN03n8BuK0KOt2IadUk?=
 =?us-ascii?Q?NcOaATPtcNoQYh2Kbigc2ZPZ6GnDgMhzC1MDqVbV4tS8tz0spukgs4hiTA6g?=
 =?us-ascii?Q?lrQ2lgQCyMWm1Rhvh4S4ucVf3QE8unXLMt+lzjNLEwiQeHyUAQQyoXFaLgQy?=
 =?us-ascii?Q?gSTzQSPL+znpRjXvaMUrGR4e3apE8Kh4czDdvuW1JMRVd9HVTx5kZXL8k5l1?=
 =?us-ascii?Q?LRNd1cDxx7vBNCdrpaWNvJk92arlVuXk26cxU9eKsNiQ2wug6O7HEUAFtkLR?=
 =?us-ascii?Q?jBdPl3KdSd7EK2YJ8BjAiRS52hXapuMCjNu21s0wscMA24xHnHFpqEOMBDPu?=
 =?us-ascii?Q?yk7emFwWF6J3bP3V2QA3Md+pvquUhcKU/zEgp2ef1WMMcynTqsDhXqBKdglI?=
 =?us-ascii?Q?NZj3uzjnIZ4vvivJwaK88kXhc4fudSDDfgpQl6BNMa8p4is4OkBGl0iLhuY3?=
 =?us-ascii?Q?pYS9s2Hm71qatLjDvT1v1eJV5pjcRiYjzOH6AUOtjGI2cI0JYqu+ffL/js+j?=
 =?us-ascii?Q?jFsHIVFDXmAIC9zE0PewXANqIma8lqd6+B+x1t1VueH1mWHROnfoTVv9GvPj?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2924146398FCCC48AEA31F7F0D88EDA3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zd7fCPWGwwraloUfmU/iAwFEdFqnzjCoZxVqYvzm9OVU/bW0OZ3oJVlrHEPmPs1ZQKz47iMzbWE5daQuvVR3CfMEqSBWhMQC5ctsk1oW2pRnczsBu0Dv9Az0lEms5sTUqFGZc0+6QveaM7GXGt9qlk1g8VBcLCtcg5LhR0whjtXShoQroc3HkF6/vmttQyii1Gk69BEm5s1ZAFYmoev0ZS8A3xH0LNYejyOdgN9bR8ld4QNfjTl9I82grBxoa/DIfBu9Mm4fQPvcA2UF0Fn8j3KSULFrPqOJOEOW8RjKQpV+KK0n2F/e15ff5qotNQOMiA2eJjiz9qjl4z5vZclO95zTLlpVKS3cEXr4+JKw/57CP9q6DKWBwQpuUpgYSv4Ez7O4nOvPWQaItEij6BuHyYsnm2l4DwsWbA9NkVRxSdlFz/CxG/3mMyMBLuSSth5IF27l7l18VNBQVQGGXU3bJX8tMiFDDcnhUEbyxUuKAjsyZyiyeoglqC95Rsrdq3Hy1uGThVc1T+YVRML2n3ERtPqSrgAS2LfsK6hno78aGkDuaGQnEV38Ya46fNOs/ssRCkUfISuvy3P1ayAIeszyR08X13idCLpjUlJq8kP3narZhPe23CuliaZMOyxzcScBP7ebN3D0M+1e6zSmWfQyEnM0rl4ApiXSZseIbXMEJ8vAch3h0UVCWuryI6P2BqDhBHwdnw2ZzlSM/YYq3bGRLxviKI53jcg1y7OCdHm2v4SyvL+tXnDTPBRQJYZzO3qBmKMgvJ7VHP4VSMSBVNinWvypd6H1OZ5Za/Xsytjgf2v+KM3JMWqNJ98A439kSxhU
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599480ed-af9e-43ea-a880-08db007a30bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 15:21:40.6777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RkmfFZ+pDp/Ct9++UQAFbVICc5gAhdFyrIxlRigvW0monsyxNC6E3KaKih/3pmV/miCD9DrSkSy6sp+CRN+pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=887 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270143
X-Proofpoint-ORIG-GUID: Wp6vB7xIeg5qk_ABo2XQf6Z26YncAMYN
X-Proofpoint-GUID: Wp6vB7xIeg5qk_ABo2XQf6Z26YncAMYN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2023, at 7:09 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> We had a bug report that xfstest generic/355 was failing on NFSv4.0.
> This test sets various combinations of setuid/setgid modes and tests
> whether DIO writes will cause them to be stripped.
>=20
> What I found was that the server did properly strip those bits, but
> the client didn't notice because it held a delegation that was not
> recalled. The recall didn't occur because the client itself was the
> one generating the activity and we avoid recalls in that case.
>=20
> Clearing setuid bits is an "implicit" activity. The client didn't
> specifically request that we do that, so we need the server to issue a
> CB_RECALL, or avoid the situation entirely by not issuing a delegation.
>=20
> The easiest fix here is to simply not give out a delegation if the file
> is being opened for write, and the mode has the setuid and/or setgid bit
> set. Note that there is a potential race between the mode and lease
> being set, so we test for this condition both before and after setting
> the lease.
>=20
> This patch fixes generic/355, generic/683 and generic/684 for me.

generic/355 2s ...  1s

That's good.

generic/683 2s ... [not run] xfs_io falloc  failed (old kernel/wrong fs?)
generic/684 2s ... [not run] xfs_io fpunch  failed (old kernel/wrong fs?)

What am I doing wrong?


> Reported-by: Boyang Xue <bxue@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index e61b878a4b45..ace02fd0d590 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5421,6 +5421,23 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open,=
 struct nfs4_file *fp,
> 	return 0;
> }
>=20
> +/*
> + * We avoid breaking delegations held by a client due to its own activit=
y, but
> + * clearing setuid/setgid bits on a write is an implicit activity and th=
e client
> + * may not notice and continue using the old mode. Avoid giving out a de=
legation
> + * on setuid/setgid files when the client is requesting an open for writ=
e.
> + */
> +static int
> +nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *nf)
> +{
> +	struct inode *inode =3D file_inode(nf->nf_file);
> +
> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_WRITE) &&
> +	    (inode->i_mode & (S_ISUID|S_ISGID)))
> +		return -EAGAIN;
> +	return 0;
> +}
> +
> static struct nfs4_delegation *
> nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> 		    struct svc_fh *parent)
> @@ -5454,6 +5471,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct=
 nfs4_ol_stateid *stp,
> 	spin_lock(&fp->fi_lock);
> 	if (nfs4_delegation_exists(clp, fp))
> 		status =3D -EAGAIN;
> +	else if (nfsd4_verify_setuid_write(open, nf))
> +		status =3D -EAGAIN;
> 	else if (!fp->fi_deleg_file) {
> 		fp->fi_deleg_file =3D nf;
> 		/* increment early to prevent fi_deleg_file from being
> @@ -5494,6 +5513,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
> 	if (status)
> 		goto out_unlock;
>=20
> +	/*
> +	 * Now that the deleg is set, check again to ensure that nothing
> +	 * raced in and changed the mode while we weren't lookng.
> +	 */
> +	status =3D nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
> +	if (status)
> +		goto out_unlock;
> +
> 	spin_lock(&state_lock);
> 	spin_lock(&fp->fi_lock);
> 	if (fp->fi_had_conflict)
> --=20
> 2.39.1
>=20

--
Chuck Lever



