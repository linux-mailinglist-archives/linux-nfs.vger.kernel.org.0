Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6736A6644FD
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjAJPez (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 10:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbjAJPeh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 10:34:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CBA1AB
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 07:34:36 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AFRqq0020996
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6SRfdPM99Et0q+p0OhktH1M9n/wo/EwrNRx9tY6NGpk=;
 b=fjHgJGe2PnOAPFyHGmYenKY+W1vXZrCJjFSRTmutOBW5BygrKylBadIHZse7AUzMz3yf
 gN8aozU7KhMbeMZ10TgNdH16uuojvoUJd28vPPMR1ek5lFlly8GtDzKOD0SpnJrBkbr0
 vgYRlCCEHRbNLKdYMM0pEQQ4qPHSdBByR+djEbeljYzdR+UbWYtn19kFrEHLpitKcEmW
 gHKGHreyG8tsd8Bkp9c6QFMuh50AkfcL6fVjLC39SKLi6zF250lPV9e1GZtL/1C0RTd2
 PUbV48k6OSOeb2rXfsihi+MJBLxAUdgveIt/1FMzU0Qmru/LmD0HXLPCU+bPBhv8o6GG RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n173bgjvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:34:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AF3sSH010806
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:34:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1ab39nj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:34:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvPz8RiGBb7ZeR9APfQj/RO5plbcUzgxyLTBKpAceMRh7vUncp44KlMy7NBznbUYIBCWeSKklhvShNOvF/haxW3BZ1ymk17clX1L9++NyiOFIR4rjVgS3q+TLT0jC4uv10vXOyb+AG3emkx3dwB/MlFfG85NfVg5ghvJLr8HOG51k+NkfNaXElNagDtA2lR5KASWQt1MzktaeaJ7qFmyiJIkcFVgXqIp3xUt2yzM2peLfSZZxIIZzGL5mOVWbAWkAX7qvci863vzshKWkQ179x9nWxhVW0XdtomK04sqI15PKpD+CKAMT8uiBgrThAs3gqC2h+heF2qXMneNdIciQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SRfdPM99Et0q+p0OhktH1M9n/wo/EwrNRx9tY6NGpk=;
 b=f6VAMU0879Sj4o2zUS/cqLg7UT6QMlmdXWlVTsw8UmDJubDUYuZR1t6GI0ELwKqbgX42AZXnIf3AxUatBw9sMDtXYgmA45YArLJCXRUexPVEwLMb02EvhcJkiw/8F7ca8ifkdQXwkN8px0eFUMM3OSWqMIsh7YSGkeoWSLyn4Op3wCM2llsMFt3yutCpKIfD6U3uOd5kcYWcjB6rja8sIqXhUhiGDoJMiQnsnEP+hRMcsmnNmC+pH5+kViNhrqQ0BurHBrLPAOgEceucFAHVsKrB98ExDVTRPhv9TDnhdTjNnImQJ/k1Hh4ywIpf8JAC60xp4STiyuMBn5aDlxUhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SRfdPM99Et0q+p0OhktH1M9n/wo/EwrNRx9tY6NGpk=;
 b=E/sJv2WSL2oTlo3MscwfcO/rYVJd+Ykk/fbASk0x5ih606v9b6ikSrWZl4t2maeaE8G6KCwTSqEwKvFaitLAtF0SVSTo31Z78uXLoc3MDUf8UI5NXkYoOhSutG2JLpR3+IEDaTUi0iwAiTghDbeQK0pz779TR/Ta56/TbrSQ3GE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Tue, 10 Jan
 2023 15:34:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 15:34:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: register/unregister of nfsd-client shrinker at
 nfsd startup/shutdown time
Thread-Topic: [PATCH 1/1] NFSD: register/unregister of nfsd-client shrinker at
 nfsd startup/shutdown time
Thread-Index: AQHZJL7ZsLhGFEQ6jUSkrloWj+GNWK6XyJQA
Date:   Tue, 10 Jan 2023 15:34:32 +0000
Message-ID: <0628CACB-50EE-48B9-8871-A1F6B05DEBCC@oracle.com>
References: <1673332991-24406-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1673332991-24406-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6233:EE_
x-ms-office365-filtering-correlation-id: fe221ab1-8c07-4679-3022-08daf3202c19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WlFDe8C5M1KqXkcoHchtnljVSqls6+dc+AhfZFNaRnvhXSpUggDGhuMHZzQVvlbYyKUbtHDZYY+KTKSoUyn5z7qeGsK+Yp71AA3ulFfgOlCw35AmhT5lKeO0VIjZcxJVZOof00xZ6SWRVne4imAkmKdk0XqdCU4OVSiBYMvpLZKXx7ziM/Ut3BIKyWs0AjWDnSzXVdk9/9p5v+6cJVAGqX2bKNwo2+3qaizvleG/B8ndb/UdwxtOPMsYegk5nDK4o1oYNP1mfuz/wiYXkNBSFVdlUMbV3Ah0gZAWtSl8f1kE1NqIjPjEAD8aNmZ5dJQajtUV/hpEztvDtcI5Rq+Kx4G8sSMPld9BeNwlbIMdIU8Gd9TITd2cqoOSuMccHmatcHchFoh1ctHhznHaoWqX3ukSAB1u+Z6ixcTJpwBiwaakO0YECxVQxKvkbqNgYyVqvOYqrOdwREuGGiYDc5X1k/tqzvTpJKF6i1UIk1b718USsI0asw4a4cjmSL0gmWQIAQnlJTz5c/yz6khSFRqisLxb5ONs/6L1SW8Y8pd4oRLhb1i2sVpj2HmfWsqRMShlJKsj6Qj/WhowrtnXc6ygnBB/LaPHM80EYkKmxDT8PPA78K2nCuR3msCAte1Z7ES89VdkkTLqELVE+yC1Gzz5epvRtSCeDrI4VO9VuD7X02ckgcKmriQwGIamz7LSKijR5Sj8HplQ/pLzMDOo9+WxJCOFbI0/lzAlqhVeUxhMEQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(36756003)(38070700005)(86362001)(83380400001)(6636002)(76116006)(8676002)(66446008)(91956017)(66946007)(41300700001)(4326008)(66556008)(66476007)(64756008)(122000001)(38100700002)(33656002)(53546011)(478600001)(6486002)(186003)(6506007)(71200400001)(26005)(2906002)(8936002)(316002)(5660300002)(6862004)(37006003)(2616005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pLto7l+ApDIUOzjGH1kFxERS8wi+EtuECBqAzpOZTQi86JJaaXQ2Op/XdnxP?=
 =?us-ascii?Q?rvvJbQ5dVbkueqg0C+bBgN8GCWRUInbLQ2Kqw7ijD/R2/sghxoYxVppFaVeS?=
 =?us-ascii?Q?PowF6zza1kaZzWeVFgRbuDUOPv1JgjGTiuKVcKC0srBGtrv7IMAEu4n91beP?=
 =?us-ascii?Q?9XVI8D1KOqM6qoHyr812crZw42VleEOH+HOSBa6xyCgeZwqNSOWbPHHu/D0V?=
 =?us-ascii?Q?sAUchf1rV3clzUw81NPY2L3YsZAHjR9Ck00gET4PRT1/dphkmDzCCurkIzvS?=
 =?us-ascii?Q?zRW5vnX9Mlo3uLQIiBXXIA6RkysTCPU2q0JfLWDROvgCiKLgyvfyUJEiUHJ5?=
 =?us-ascii?Q?w8ro6Mg3g0CxRmoOcxKtdDUQKR/fYkhxXvMPa7lwlGUz6q7F1Hr+0b3YDsuR?=
 =?us-ascii?Q?U3eHm656UaoqJ34/VYc4/LvWZXi4a3feTaOLNvgnxG088VhISyb9mkAviXHL?=
 =?us-ascii?Q?9tTUX3/1xVgBS3AjlJsULpE3CJFZtb882wFDvuHn/mz5d58uvMe1fmOKnWbr?=
 =?us-ascii?Q?HGl5LBHtBfIG2yrRnhEZAP4ATdVb64IBIXDgM+7UNDaBTu7F849FAFOSWubc?=
 =?us-ascii?Q?3xmVsZ4kyMFbqNosMZ+bNB9JrP2UEWwhEw3WKap/sDXQf87SbRP0B2Lh3yJV?=
 =?us-ascii?Q?ztadCyyCRhQsq3wdk/efS4m5lxHaTsvbeRhDsRWPefEy7xY/vIz9Ro4fidL9?=
 =?us-ascii?Q?/biwdjrQRTVHSBDlsperFqREzO+hCQkCab+KHk+aoaUVGu3Nm/OfOF2a9yJa?=
 =?us-ascii?Q?OijWCZ4VpUCVavV92K7/cWrX7cm2C8mxFlw/V5E9NOh0s8+iNqH1F3DRlVr7?=
 =?us-ascii?Q?U0oelWVelh1FcHQuZGjSNXI8csJK7ch37dfjHcfvPZHHJQSEj/4BNWAySln+?=
 =?us-ascii?Q?nFBlzDQx2Df05SlHXJw6qJ5xbrs7R2K4KQ81RE6R5AYsD3XhjgjAAt2A7LPj?=
 =?us-ascii?Q?ZiM4vxGxKgMQRVH6nKQVcO2HMgL2iyjmzwHN0tkLGGTQWwQfE8clVhKGmUSx?=
 =?us-ascii?Q?lK1hs+SMEw+u4/Dcylfc2paMDvIFm/yIg5SUU0Dgy8cl+9nzyuZTOqK53EvJ?=
 =?us-ascii?Q?OLRcEmV2cB+a7lyprWUO9e2s+/+TM9V004DZPruVsX+Jy+bSKSFOIwqW4MQR?=
 =?us-ascii?Q?V/F5E5zAfBme46/K2NOGQAeJMDd+riYS3NmXGO9M1pn28WcYYbZTeq13lIgn?=
 =?us-ascii?Q?kSA8aWL2xA5B2cbUFg4wd62hy8FaW/beJRP+Q2rSLYJzDW+x+/zk9b0gO6JC?=
 =?us-ascii?Q?+s4/vBCdVcTJaZc4OK9woiFWJKBQMscEiU25bqvaPW9rI/7+4GqvNZyocD9N?=
 =?us-ascii?Q?94/NfNI2P/kq/LwLwmUoEpKPnZd+YPm5okRKPfJD9tH7VxCKHJWHp/uo/n0t?=
 =?us-ascii?Q?FfXYUpNyzA/BADt+pLZPlT0o42+fc2UKbb7jBo1Nd7Hc+IkQQqRgbB++vPMK?=
 =?us-ascii?Q?hSXerBJ612jf06GJeAJUENnu6wZXMPP2ULk4vwhzqg3hrYKjkre55o/7pNmc?=
 =?us-ascii?Q?DiVBZXNOr1rRLJBHQIeohyBDEHQ0R6oIsQq6lHYeNpXqj2/RMeSBnld5ISi9?=
 =?us-ascii?Q?luS5RUaKyRIlq42Hc97JVtzqdX6yLUf1j9ivuCVRrDRviRiRpJV9/WomoZ30?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84A64984E8329E41B78069CD6D7570C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RM4lDZ41b2L9uLqurlrfRjIqMjHjYgp5fPUUIqjRtqTwNk5aCICaaYmhkpDdzHrffdqdH/pvVl0zqYAJ2gG/RVyho+kRW5QATRDXPZmY08qQwSYIl6wAvVCZEZARr72Ac6T0hl0CLZSSezsbSltUiIbt7RYwkJl99GLCXiWwnvyjPxjmg/EktVkMRWdGhGrOJaRZbim00Urd4eBKD1YPOc9YET/UiiA9ENcHyPRj2yucKfu8qytVTIWWNaCZBM74z3UeVF47rsMP3FGG9rzxFxpoSUnZL2nJY0UAKhv7BpAQNLpBxAFZjIWnl0jQdnys5xsG5FAR/2GeQc+Fxr16vh/BMqZAjB9tGSAr5oLwOHlax7SLRkMCChsjKK44o+zbkxppsJkpxWJeChFoxkuFsB5iBglqzS7vc5hJ/NbCeyk3WV2Ig+9wrfHrZfVdEGFMLVm+FhrCZSvg+6aWGljz1xZ784ynrB6+h4kxLrmeS5ARuIdqRNJBhXMDqLT+uSWIKVQepcxppIZXlHcIaQV2bupqkZkhlIxp83akSFRN/wrA/13rfWcpHGU3BuB5ogAjbGkxRjOEgdWHcOd1G8m6guO49GQfnqAeNHm2jxSbXWlM0xs1LLzBKfG/kqqo6tG+iPTplrz/cpYzLcARaTOFfs7qQvB0Ev8h6tw8IA4sWLzqg/gg4T01NSvg2Rpz30LsF8JdUbj9RdxPaZGk+FuljWCJPlAo2SfCyFBPukpksX6AbVu3H7In968bRZQnBhX3RE9ywpfYTihtuZvotYVk0Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe221ab1-8c07-4679-3022-08daf3202c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 15:34:33.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJUnyrjC7e0jwAgE+wPtxj6hk4aT0ABWlrKExnnNg0Tr6+QnHB08wcY8apUUw4lfIaeeJOXiidctB/8dJqzGKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_06,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100096
X-Proofpoint-GUID: OKSriiHpC5lit_QrkQyW8uBNWXHP-H10
X-Proofpoint-ORIG-GUID: OKSriiHpC5lit_QrkQyW8uBNWXHP-H10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 10, 2023, at 1:43 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently the nfsd-client shrinker is registered and unregistered at
> the time the nfsd module is loaded and unloaded. This means after the
> nfsd service is shutdown, the nfsd-client shrinker is still registered
> in the system. This causes the nfsd-client shrinker to be called when
> memory is low even thought nfsd service is not running. This is also
> true for the nfsd_reply_cache_shrinker.
>=20
> This patch moves the register/unregister of nfsd-client shrinker from
> module load/unload time to nfsd startup/shutdown time.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 18 ++++++------------
> fs/nfsd/nfsctl.c    |  7 +------
> fs/nfsd/nfsd.h      |  6 ++----
> 3 files changed, 9 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7b2ee535ade8..ee56c9466304 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4421,7 +4421,7 @@ nfsd4_state_shrinker_scan(struct shrinker *shrink, =
struct shrink_control *sc)
> 	return SHRINK_STOP;
> }
>=20
> -int
> +void
> nfsd4_init_leases_net(struct nfsd_net *nn)
> {
> 	struct sysinfo si;
> @@ -4443,16 +4443,6 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>=20
> 	atomic_set(&nn->nfsd_courtesy_clients, 0);
> -	nn->nfsd_client_shrinker.scan_objects =3D nfsd4_state_shrinker_scan;
> -	nn->nfsd_client_shrinker.count_objects =3D nfsd4_state_shrinker_count;
> -	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> -	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> -}
> -
> -void
> -nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> -{
> -	unregister_shrinker(&nn->nfsd_client_shrinker);
> }
>=20
> static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -8077,7 +8067,10 @@ static int nfs4_state_create_net(struct net *net)
> 	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
> 	get_net(net);
>=20
> -	return 0;
> +	nn->nfsd_client_shrinker.scan_objects =3D nfsd4_state_shrinker_scan;
> +	nn->nfsd_client_shrinker.count_objects =3D nfsd4_state_shrinker_count;
> +	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
>=20
> err_sessionid:
> 	kfree(nn->unconf_id_hashtbl);
> @@ -8171,6 +8164,7 @@ nfs4_state_shutdown_net(struct net *net)
> 	struct list_head *pos, *next, reaplist;
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>=20
> +	unregister_shrinker(&nn->nfsd_client_shrinker);
> 	cancel_delayed_work_sync(&nn->laundromat_work);
> 	locks_end_grace(&nn->nfsd4_manager);
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index d1e581a60480..c2577ee7ffb2 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1457,9 +1457,7 @@ static __net_init int nfsd_init_net(struct net *net=
)
> 		goto out_idmap_error;
> 	nn->nfsd_versions =3D NULL;
> 	nn->nfsd4_minorversions =3D NULL;
> -	retval =3D nfsd4_init_leases_net(nn);
> -	if (retval)
> -		goto out_drc_error;
> +	nfsd4_init_leases_net(nn);
> 	retval =3D nfsd_reply_cache_init(nn);
> 	if (retval)
> 		goto out_cache_error;
> @@ -1469,8 +1467,6 @@ static __net_init int nfsd_init_net(struct net *net=
)
> 	return 0;
>=20
> out_cache_error:
> -	nfsd4_leases_net_shutdown(nn);
> -out_drc_error:
> 	nfsd_idmap_shutdown(net);
> out_idmap_error:
> 	nfsd_export_shutdown(net);
> @@ -1486,7 +1482,6 @@ static __net_exit void nfsd_exit_net(struct net *ne=
t)
> 	nfsd_idmap_shutdown(net);
> 	nfsd_export_shutdown(net);
> 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
> -	nfsd4_leases_net_shutdown(nn);
> }
>=20
> static struct pernet_operations nfsd_net_ops =3D {
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 93b42ef9ed91..fa0144a74267 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -504,8 +504,7 @@ extern void unregister_cld_notifier(void);
> extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> #endif
>=20
> -extern int nfsd4_init_leases_net(struct nfsd_net *nn);
> -extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
> +extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>=20
> #else /* CONFIG_NFSD_V4 */
> static inline int nfsd4_is_junction(struct dentry *dentry)
> @@ -513,8 +512,7 @@ static inline int nfsd4_is_junction(struct dentry *de=
ntry)
> 	return 0;
> }
>=20
> -static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0;=
 };
> -static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
> +static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
>=20
> #define register_cld_notifier() 0
> #define unregister_cld_notifier() do { } while(0)
> --=20
> 2.9.5
>=20

Applied this one to nfsd's for-next. Thanks!

The other patch (once the review comments are addressed) is
to be applied to nfsd's for-rc, I'm assuming.


--
Chuck Lever



