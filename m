Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5EA67D7C4
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jan 2023 22:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjAZVcv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Jan 2023 16:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjAZVcq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Jan 2023 16:32:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF62974C13
        for <linux-nfs@vger.kernel.org>; Thu, 26 Jan 2023 13:32:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QIT2qN024202;
        Thu, 26 Jan 2023 21:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=W+oQGFGX3wo+g/a94uAUWauPGpoMpWKWepQdydGlsnI=;
 b=d5hZCNkVRiyAJUCEGfnILPXENF2R4s/HLgQuKF2pn69NfsHQfg/uOPByrVENjDHHx2Em
 BSa28Hz2FFedUg06+DCJys6z7XlS8QEaoYoBTToz7N9RMlGQlI6BnG8CSwj+ESzgl/8h
 hAh3aioKIt0JfjCL63Gm0bJkNlBJP7erA57ZcIJZu2GKZGAUnCNt691tHQcNK0oI2/mr
 geF0aLwGM08IPepBMDn6bjrL358zmh1bfbNNcN8Ggt7dTdWSsiQV7dQk+2HyPfs+aU6K
 XLxkK6CnjbnDznfFVrlA7b+obVTooRzcKy2nruH+amYPgalKLxYvuN2cfg0AcHsU2aIa 0w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87ntbgnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:32:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QLFdVV037298;
        Thu, 26 Jan 2023 21:32:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g7xd1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 21:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRS/P22U3aMxr9THgadNo/KVNd/1x4Sf5ZfgHcF8ZKJpQ2B81MMMTKu4G2H8e3NBxwH2g/kFvttMheZciHNBcgM91+Gi0ZrGv2zOHRMqE7RtEL8nrH3NWO6yzMkuUEZtVQ6rP6mVeTbyaBslBKZoknDvvjgRWsdBLkGtD7CikMLd0j392GLLmiMfIeGawrZVOpYy4E/T1AKwVlUDo90/5fxj8tVD3cigrOhrk0wsF0fnPdtFtb/8TeMGjJ9J4oyxRPCeT1NUkJ5L7CcIROOlEliL69HNAV3UOxAvDHcKqjw9AGwGABZAQm0YiYujFpGy34UePpy9Skj1BWaZHXIekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+oQGFGX3wo+g/a94uAUWauPGpoMpWKWepQdydGlsnI=;
 b=YkTroGLF62MN1mTz0YhF1ywMrXpKIUSllpRCUFYB6EcW/yhBZp31kbZSzAxd8jMUj8bOR8feCayjUFMLPhEPL9H27fqAYkN2bXuTNfpUw2wNiu5reZi+mtlwe4hCJzodibFfK8Edsee8EQW6nC1AtjhsBfey1y/QvIQvtnGzbKbHvJtbIiwn8PfcRKDRHEn/p8UNr1s0vum8jVd3q9NRWnE3lQ4gp/jIPEXYCdOmNrT3F9c97liia+buldTBmEVBT70Q7iKUSoe2CJIvEStmCbo/Fm/Fn5nZiZy15/wlbUSrjyHPNz5eX3FY7RwKMe6pMIPax29ZQAuyClToOI22Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+oQGFGX3wo+g/a94uAUWauPGpoMpWKWepQdydGlsnI=;
 b=S4L9iKa9zMqoFEuXW6elB0KrHPgUbOvHpDFJXJUGWHTgQfbAEO/qpxryL0ppi39L+9AwCRG+p/y4SVutEyWwwiCSK846WZL45oSSDOarbJ+pQGHEDJ9L6dfC50yF0PoOnZ8tBV8VPbpQEu7DRSazcNywWIQdgQuZLrlatqi07qY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6306.namprd10.prod.outlook.com (2603:10b6:806:272::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Thu, 26 Jan
 2023 21:32:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 21:32:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: update comment over __nfsd_file_cache_purge
Thread-Topic: [PATCH] nfsd: update comment over __nfsd_file_cache_purge
Thread-Index: AQHZMaqd+g0lqDJ3/Ui8X0ffJBLTb66xOAgA
Date:   Thu, 26 Jan 2023 21:32:27 +0000
Message-ID: <BBBAF186-1825-476C-B457-549410E8FC5E@oracle.com>
References: <20230126172116.198443-1-jlayton@kernel.org>
In-Reply-To: <20230126172116.198443-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6306:EE_
x-ms-office365-filtering-correlation-id: ca88e64a-9d4f-4360-753a-08daffe4d2ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DBJ044VpQkzsHrcT6Y5mwdmV0yklxC+4JmCcjaHuE4cb84YW5W/jNa7qnhy7HIzmFmbhFlrvwhPPxVfWdgZ4Sv5Ouwcuo1alllStFoBFITyanErIGInOFgcd6NLmY23kpFdkTW0q2bUr4U/UYyd1rhxI5LFfpDWwclH1917FakDYMihmzqt5QmXPmbyWTlqIx5GahstdMTY022oIgnQ8TIz7ljbHCqxQ2N5Pf+iV1gCQitV9d/FYdfhEOl6/6jw6v1beGv0GL5mExxwfQPGBRdxR8IvnXYTpvbt/nCZwaN92CHQj5bV2/d33DFTx7l0d7G3FgNDLCRbOhxRhUrX7CjhJXU8Z1PvsnVEbtWbsNt8hom3NCscRjaK7a1U3kfVg7cglCbiEiiUwaEINYN3Uk1N3xmM1QCALm8i37MG+l61k6DkdYmgpzOMlkZge73D/nSAtEsmeyiUaBgheDKq6tiBuG7OQyU3L/lsXcM7CeFjmP62RavWkGa/cqBMdiKQ79mYS1/M8CSZIPOPl9aHSiohU7qikyV27k1Y4xx81/tiag9gGFPMxRjPlBPW05QKmKWOBhHa5Yz+r33dLJzKAQ7TdKNywczf3HbPoKupLJm80/TkhAJ8YcQQiGnVMrtpvB5sNmNDvfAcBW2du+8FD0EIDA52PWGdyzIz084uSTYqN/EQqX+dsUrzIiCR4y3xtRkMg9Dkkghqt78X8W7YxJTNmzJ1ilPdXaA5I+bOUTiI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199018)(478600001)(71200400001)(53546011)(26005)(6486002)(91956017)(66946007)(186003)(6512007)(76116006)(316002)(64756008)(41300700001)(6916009)(4326008)(8676002)(2616005)(8936002)(4744005)(6506007)(5660300002)(2906002)(66556008)(83380400001)(66476007)(66446008)(122000001)(38070700005)(36756003)(33656002)(86362001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KvT5fEzi9pC4mEFNgJWEZKI5xphUVcVeyEAiv0B3JRuhMhlX9okZQnGJTF9I?=
 =?us-ascii?Q?Mp5+7LwhhAQwVnC15L4sFA58E99oVf6DkdZlWJg2c0yoPRN1nBNi5gL0Mqlq?=
 =?us-ascii?Q?9KHOcZq4zvw2L79metboqkORmQzsWQ33bMK5m5zFq3MemrV/IhRLp7INRJgF?=
 =?us-ascii?Q?Z02Gy8Fav9XU8DQvD7P73oIygMRki3Wdt9htswZR4opL45MeDddpixhZV15y?=
 =?us-ascii?Q?N2EZWbgSnKOfuUOi9VAgA598SGHzlWVoA03Mw5Y13fvPQ4IdG8aIL9jIZ8eR?=
 =?us-ascii?Q?0N8Hn6p8lvJRFPCxY7KdpIWRyJ3daFjNNfEMUxDyHht+szYc60XT4lvjzLbL?=
 =?us-ascii?Q?+eJArcPJX05atMOiLIW7HnGMGHJHb9P0utkPHrwnpBQWtoWxtUqirJyqvzQe?=
 =?us-ascii?Q?cJQjIL1ZI5uiWCPqRqucTH7pMg2CatL+7UxHYooxwpGbWtkLIO8uxUURzmNF?=
 =?us-ascii?Q?ATTFvv0g/6F86md6f5XFgDEi7DJt8scb3Tih++1gU5coefzx3DD2vdwA59bp?=
 =?us-ascii?Q?a171Wz5wJvAHTim8ygZCO4p/4esPUoW/pZjpiUbeyyNXC59KNcO6iBdAykAJ?=
 =?us-ascii?Q?+BYgyMqXTBXKdUYw/4WfHqJvy7Nd4c91djOunwBlxbBHYfGAwB2hYAnPZZ54?=
 =?us-ascii?Q?SaPfc1pMYuDJs7GI1y/9rnhnepBG1C9rAV06Ukl6yPAFSsYZIaT0nYZ4d4yP?=
 =?us-ascii?Q?uL7lnT6ZU5REvXST0ybdv1UMW01n3/1pFgaPOgfBZd5+K+ZiOzL9sczmN68v?=
 =?us-ascii?Q?N1DFomDkiyIclU8l7vmf5htZU17zY82oB23Mh8FS/DXfmn6SSKas0k82tF+d?=
 =?us-ascii?Q?Q4AvDKEqHR1sSJoteQvCgqMuaCcQtpauApyQo+SHLtqi7NErive0tHnZ3kAe?=
 =?us-ascii?Q?6dVtroSJtNjL3Ra4ATFYWElCHvJcyqS7GmqhJl01fmYL/a/sgo7hgdpedmMx?=
 =?us-ascii?Q?DIa2ZVhQucmJKyW5QAy3flIlkXbeteYSxNmRkr+Yt0fTgfYfJCSzBi1K3RvF?=
 =?us-ascii?Q?WQAV9vZmb9x9DdPsDuCelP0KLB5tBqYly9t9n0msbyOnp4Hfh0TUK1m8544a?=
 =?us-ascii?Q?U8/gUmY9wdw3PfQioOsJV+s2sImmWV5QL8zW6K93aqHZ3BpC52OF8VZ/YQec?=
 =?us-ascii?Q?EzLc6E/Psj/Y0mA/4I6vmyJcPMlqw0JKOefF+2CR2zoA0o6bAl2a3iKunCZn?=
 =?us-ascii?Q?l40qWksAH2iAlWfJkcVsTFwHzSiT+2Dbz+nyrLDOAQfJlOuXQiwGMnT2/Y79?=
 =?us-ascii?Q?oCPPEOoimwPRKVl2ysPfXSETKYE+DWGb/49a+OwetBL0JJXO+xba+5bvjOuN?=
 =?us-ascii?Q?wfHlWPwOQ8ZyHjHbfsb7JwfrlwG0fvD0D6+2hyOWVBL2ZZ+ZfYXNfLLKPZmp?=
 =?us-ascii?Q?SuNu5w9a+bzg4Dt8nyZ/Q/7G9BdZlHw/XR2s7a6bxbyGY5hXf1JVSYxrqvND?=
 =?us-ascii?Q?50ckrgczLewsyqYtSDT+MKRBcowgFylx3nM57HQgg8ToeYL8Lm0GesdzU6fj?=
 =?us-ascii?Q?ee5ycHop8Bdgzcji+09kpjcEvQhRWPnVjklDI7lTQ5sbavgfDcFvRss0Lh6c?=
 =?us-ascii?Q?mCM4RUOzUWZ73JhZdaHCl++Pnqxpfz6ENnd6ds/oS7rC2UEcJz2GmYKM97Ph?=
 =?us-ascii?Q?7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <567390E1C5865F4F9DF9E3531DFAF3E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: to2gx2apz0z830fTRAXJasqI3Raba/Xjz0bqE0qZmBKbQqtsSUQjZ4XqNfvwNyLEnVmTie5/ugNJy9arXWCRg73EzdvKOKGI5iV3Y/AM43o03VAqYptqMxMlwdIdFAMrXp6GnYXJ7CQ3K0mBhLFfiiSciUJJWxbIvyihEXkA/1VwQxBmtS6QuVUemunn8otdrIluE87nNWGLmRvfxjNfMb3H6iIAZKunhdbdiJa9K8mrWYdky7LLinoiB1L95/TL+jPZJqOozpO9ahAcGaW1gZP2RGrjq39P03+lCJpKqTcjxbDdQDaNb4zt9SzPvCaNInoOvnelGTcqKITkNKSaecg+t+iMDUvDXr1vByYAtx9TOKz3mZnp4m7UnChepay3kYlb+173EnyWW4vsXvqDbXAuWSrfb07k6HP8VfKH9/L0XuFLgcOSUVPdwErKZodg/C8dYs5AYxnkWGRb4sQVyBQvXXKhqRNRTLozGVAnQ8l3LsOEACb/01jtaCG4bpI4MQ3J0fjRP7vnItH77L5o+i5zYqKOf57DJK9Yb004Rp8vzGx20u+Yr0SRbYFQwsKRjaQ6JaZ9GC3kW2fTpxc/ue0O12fFi1eaLxTbF/RSYT9GB/hlRAZupJhe7Az4XF36xZLJ84EAvA1Qkt96dIjgC/8SiY1pmqxyolRvDI4ka1+5Pn7iE1zDzxQcJWOhneR7ypFQP3izVzG3KYhZGvtXOp2Xbs1h93Cxv9qxnQjxrOr/Uwnr8i1vJlV9yUyYRyJU63DVJd+4tXuqHPaA0ipraoa727cwvz6xVG/o3JvFfTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca88e64a-9d4f-4360-753a-08daffe4d2ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 21:32:27.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtxQbQaLwp3qu17GYciCNXbw7UT/kfPf2XPdRELrKC7LI0mFVIMgnZ6nYZWupro3I6HWg6aiPqYubx98j3MoQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260201
X-Proofpoint-ORIG-GUID: peYU-iS0IoCY9ZylIEsnq4AGgljGcPHn
X-Proofpoint-GUID: peYU-iS0IoCY9ZylIEsnq4AGgljGcPHn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 26, 2023, at 12:21 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Applied and pushed to topic-filecache-cleanups. Thanks!

That branch now includes nfsd_file_cond_queue(). Can you check
to see that I merged it appropriately?


> ---
> fs/nfsd/filecache.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 348ef543c4dc..e232937fea8e 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -808,7 +808,8 @@ nfsd_file_cache_init(void)
>  * @net: net-namespace to shut down the cache (may be NULL)
>  *
>  * Walk the nfsd_file cache and close out any that match @net. If @net is=
 NULL,
> - * then close out everything. Called when an nfsd instance is being shut=
 down.
> + * then close out everything. Called when an nfsd instance is being shut=
 down,
> + * and when the exports table is flushed.
>  */
> static void
> __nfsd_file_cache_purge(struct net *net)
> --=20
> 2.39.1
>=20

--
Chuck Lever



