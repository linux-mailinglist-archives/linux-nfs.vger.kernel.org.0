Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5F5F49F6
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 21:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJDT7a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJDT72 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 15:59:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C1A69F60
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 12:59:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294JnFTI014364;
        Tue, 4 Oct 2022 19:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bJYKz8ah0IngLVZFyZ9a7DQ298cOt70LVWEqyq/FtaM=;
 b=vGIA2S0ANdATktAsF92mBlwddlYCj18HkVkU109piZeKNJpUInqXhO1JA2K7ryAyjP32
 VxPXmU76RFyheyZ1dq+jBZKJxja2LJjmjY7VzBOAbDfDS8t9rANxJ+YlvtxE8qMJScHE
 jBXPc7XjP4KLBYDrnJgswMud0XTRep1FmTG1f5K7vylXfW33rj/m10vxZ1eDWS2+BpqM
 GH5IWVbYpFSAyLt92cSsqPs88Bo6quJWcijw2Pbx6p0XKDgCzccDNiqSX3Lsw2Pd762h
 xm43k23escNQwj4xFdTVPen5cNVlyDB918DyOnE17xVUwcdZJfU/APSaNAShfLCKLxUb TQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea7m2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 19:59:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 294IV3jq000489;
        Tue, 4 Oct 2022 19:59:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc051pdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 19:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQKhVZq2eAlOx4hE0cNpZ/8ao70g3LhEh7hgirfqHHPOf/gDP+S4zakZeOSltQ/rKvz1pa0xzNTa0Cby1LvYqDFPBZ/lN832biIz4NJKy/67FUhcqGquw4pA99ArvpizJQ08THQX++42spXIXjhvbhPJInxaEHYe5mgAFh1FxY3BHi1BNJ4xKskdTE0Z5T9cMvcb29o8gFGvO3tqHPUyEU+K7YmA0KwpuiXJH2dh1cAp5d9JFPHaerkTCMlnhJYbrO+ejrqHkXH1gw3CwCmZRxZnugIdRXsAbvt3CU0lpeFcmRKQUHYYbNL38nG3cuOjcilb1G/WHeoUnuk9R9aW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJYKz8ah0IngLVZFyZ9a7DQ298cOt70LVWEqyq/FtaM=;
 b=FZAOP7cBqj/Q/bxJwrB48iRvp09XXNdzD3c/oYJGy6RvDgLXS3FVsLoMH/CFzqS2jnuQSDUaAPXtGo9OHVfcyrg2EzqG4aAj3QDUz9T0CLUbcuso5rYvLxnK8pKgd6+zfyn91h6D0R7GlFRn8H7dkTJnaWMz7n+FKnVaWeEJPXA2Yq2sL8eewxMf3Trm2+slRob9nlVr5BwqPd97+tF7XWkstcSNwE19bJNFFMoeP644HtV/FgTmywc6wr3qzldPS2pIjuhVvra47HQ3LVwHqkFu1N5FNUD/XzKzNOwY4HPwOM79JDfRz175cVYhF/w/yiEjO+W5kk1ca1swoN/AYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJYKz8ah0IngLVZFyZ9a7DQ298cOt70LVWEqyq/FtaM=;
 b=FCejF4SfDg7mB7MjNcSojLZ+NRGtXySGYhAGq3gS5n4LjLSGm/rBpJHVZKj2I8+guvcemuK97tBZiUN99vqGJfrwl+vRIG6qvw5eEO8MHyjRjIjHIUqVoLxj/BcDHaHzmWLwmvzqFLEpPGs1Sf7yGEkxV5kWKFrz87BxugAUTrs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.34; Tue, 4 Oct
 2022 19:59:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 19:59:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4] nfsd: rework hashtable handling in
 nfsd_do_file_acquire
Thread-Topic: [PATCH v4] nfsd: rework hashtable handling in
 nfsd_do_file_acquire
Thread-Index: AQHY2ClEggmz/YlC/USTHIMpnzvjtq3+pzeA
Date:   Tue, 4 Oct 2022 19:59:12 +0000
Message-ID: <DC5A1B13-24D9-4EE3-AD6B-EA0A6C6FEE03@oracle.com>
References: <20221004194110.120599-1-jlayton@kernel.org>
In-Reply-To: <20221004194110.120599-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6798:EE_
x-ms-office365-filtering-correlation-id: 48e2db05-b695-4cb1-514b-08daa642e898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R9b/CYOq8e4Udd21cSDVKPwJDSF6SAubSwSO06ExWJzpy2lp3ZyowbTSgTVANj1VvkpblpvEKXUg7B/qtfrioqG0gElcHymZzuFh0XxnZGzHWK8MqnANtDbIce4ulMKxDlCBz+bIDyXRfEelvKrgHktnJOByEhBP00/5TiR1fWRTx4eTut1TwzZsjWYyYlBdbKZJWCRuVwdknQrJc65lMDdg8+InINThREy50FCrztpyu0rgIwpDwJJzVcRd4Dp/HQROXNroEPxdyxDfF4lSpGQHTRZl2QjNRHXZ+emzGI3/wACVq4M/CyrD9ecqVzwvbd3gYTvA/bXxkH9RUTK7VUlW4vC1zjLOrw3AZHjQtiNLIqkLrxhhDhWHl7wFiPbUmyKAiSze5gd01L+FLOCF5OYBgfQ1mHCFtk0GcKpsCYdDKReardSdtCRbaymkKCHYvRfcn2dQPTnxuEbjYRpPzRgL7qPfOjBix1nccY4Dbk9IGj/BklNQDrdiVboulTrqNOmlp58Rfdc6kQqWq/1jS47OoinxzlwNIYAnF30H68NbdjUPFG6A7HOlCJxshS+gBzIbXzsEYrEV8P3P57FYNViyNLUJoFkTGvenDNU6RQ8FtMVZ+EiuLiQK4hISpwCQ72MPlFxcTuhKQ5F2IXdjSRKaxurBaCjdyaaxFBfieB29m3GMtuOuURKTKKfic9x7VO6SrR6QfQAVYZjzOIkrvJbzDESyRFMCCVfitu7XSahq2QkZ3UMyO5NKMYW2LiZb2Zk+DA7Hm0ge+ZCGF/AjVcC+e904cUA+Wpvxby4bffg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(5660300002)(71200400001)(316002)(33656002)(38100700002)(122000001)(76116006)(2616005)(54906003)(8676002)(66446008)(4326008)(64756008)(91956017)(66476007)(66556008)(6512007)(6916009)(86362001)(26005)(186003)(6486002)(2906002)(53546011)(38070700005)(6506007)(41300700001)(36756003)(66946007)(478600001)(8936002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ETsVhn4H463mQ4Bb4iDr/sqPhlafHh8J8FtqoqAQANDhaixgzW1OIfgU6Rv/?=
 =?us-ascii?Q?6KRuGL9Q7iDT9b1VSqNdGInxXlBYFQ47Ed3lkCT5g3iN/7UtlyqQB/VwzP7y?=
 =?us-ascii?Q?jGo67Lqq2bVRVf+6B+dJiP9vKbKmbltflDdkwit9e9OwjsMxJG3yOGfYOP7H?=
 =?us-ascii?Q?Kdbrfp2Uk/lIrs8h/Nz5E40W8o3XexXRCLcX5W0tgcopAXJxMNkFuR1Bivm0?=
 =?us-ascii?Q?fAkiJOuOzCxmRHDMrYx3UhWWX5UZdHu41ao+UzZx4Lb2Q3Kbv1R3czzM/lT0?=
 =?us-ascii?Q?dVQCPhgl2Pzg5E7XyY4IehrJmKYbHxrhulcb3T8NeycdLFYTyRsja6HJaQIS?=
 =?us-ascii?Q?DELWCX6lcfkFxTIGHKV+i6hBCNI7e6vEJHuD6uJI2fXVy3ZTJ62zFrmDyeJn?=
 =?us-ascii?Q?7JNXF+DkrCJF6kevdZqBfORKf4WDTBBhYTbsKrlGE/tIJA8urNnl1l1r21yT?=
 =?us-ascii?Q?IuAx2VSjp6tptizhrfwNk7iex5sKMbg8gdSu4IBuBmv53YSLQpIo/tx5lT39?=
 =?us-ascii?Q?5VGNr6M0Igpq66r7MFheAexLq+EtA0y1aDwcKbB1m0DF9hefxBqoidMwcuRT?=
 =?us-ascii?Q?XbLDUFYOnlwo8Wq9w6Nlf7iSO1l0MNI/So+z6DFsckYfHorAYEnFaLue9a2+?=
 =?us-ascii?Q?m8x1EhFjRnJfV2OFKzvD91TuoSOKTjUWLPtUpZkKfI89jOon17NAgMh5hn3g?=
 =?us-ascii?Q?WwkxqW9D7SfzL9mxOzk7b+yxDMy9QSc35Dy+x6lz37DCbJGpNMk4gnW/Db0L?=
 =?us-ascii?Q?KO5OnjBg+Trm05mFNa3wq7lHG6fAczexH9Q6GPQpPzDHXjDqJgvV4vVUeMAO?=
 =?us-ascii?Q?5zHy/zROOIGJY4zj0d9QRIRk/IGcgQb1dZsJo4lNuw9DBATyrbCtITyYp5fq?=
 =?us-ascii?Q?kv0fPfo74c3dA/OlGX58NmZs7FuLJnb3De/bnS9vz9Ag6MY4qoiRT/IorPNB?=
 =?us-ascii?Q?7Frbb4RCFuyIMXwH19h+RT9Qyd1TxIclsUBjByq2ozbVbVwKLDE/NF092Mrc?=
 =?us-ascii?Q?7m2MwytGMnZh7xMqU7EJHGAxEOylWWCqhSkLzcxLnw0Vx/DwTjmFybh1wvDO?=
 =?us-ascii?Q?hCyBhdJoY4Q8yOps0KoR9pTdMWRc8wFQLxEJmeSIcHo8ZUQna1L2tmXAdkLF?=
 =?us-ascii?Q?ewEJ8/upRShGtYL+fQDfR6vE2tyVad+GYngwehleHz/Wz4FP6UhcxpWogZFK?=
 =?us-ascii?Q?r9XDO9x1RkqHc5NeDAu7cFaV8QIUg5gJf+euPggsAXCkd2vkw+mSWLO1F/cS?=
 =?us-ascii?Q?EBAzZBWgqRZeB4gbMlhkYWoGpurMDrrln0K4uIo27Ui3U9DU/g2OswyfoDtM?=
 =?us-ascii?Q?jkLOMmDjVrQezGGof8PrqVVR2g4WricvybtOEyNNsMHvoeDbZIvqmQ4O8dDz?=
 =?us-ascii?Q?Kzczdw2xkTUbG1oLLl6/g+1ivut9xj/6v5nP9tHvGeqGzKvqWEzGOfThqt70?=
 =?us-ascii?Q?GpmFHE3cYLGHC1l1HnBgvJx7yzYekpLgYqHKR+Ols7Ggm9NCsmOyN66tsRa1?=
 =?us-ascii?Q?+gwswPMzpoN4M8dVrQe4/6yaAtdRKtLQ4EdP/DQyNhatF2FWtRMV6YlFkamt?=
 =?us-ascii?Q?qAISOGygeX2aiDbKe+TMNTpZLHEQKWt4apx5PHfsrcf0nZPycViFFJdRwBSG?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34A555CC3957B545B6FFB987198A3B06@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HBOJaZ/KwOGni0nAcaQCdlknEWsrse8TcQWkFk5dEcKkzXgvrdUnr0o6JepvKKDeLIodTaXg+Ge5MKPn7fI4x4GSGpIgetWXdB99FzdPiW0hL/PSZZMtNbHAmqCthIIWzNejTULgHuR6kRQg+bq8cUujiAhwgj5P8eJIHwyfigvJfZL6zcKYer5Na47j6T/DVCUDwwBS6v/GUN+k4EXEH6a7v/hFBbe5lX5t5qwN26zrXT39B5pxCwudjI28T1kIVSu2e6uOPSWPziDae6DN2ARXbN+uCaalrCU9ijQL6Hv05rVJ31R/eDrYgfIS+L/w8Bi1J17pvPuPrDX7SdhYKZSrdfqYj5Y91WNJGfsQYND4lWQ8FPApKpx1pLS7acc8hJveZVBxAp/mfeTBsnbZGj9qIOHv5eFZ6FafNK+bN7ne67puKZR8m7PY2VVGZaZnlWVA+lusbV1ATn3Ax8T8EO2MQu8lawFhjMA3dTpo6Yolp9VLsNx8z6jSWUfpAK9s0VYu+0MgbsXx+SgkHD8a85BkijF5QELlMg6taHQIOd+1j8ieU8EQd0dKy2qu8gfmUES+9aRRvRHoO26iMDBkmWyzcoxwXiHwcdJfyvL9Qn/CV/4gzjHlYFyvJ1GoiRjXCMZjfWfNv3earnOdA3NIEVGGwUtP7GmM/zdEpOOewMjC78XauG5nb329IcseK6lR10tQcnsOOkdoYvcqP1F58lHq+RKvS5vkfogiHx6l8oA4JMEaG03Ah+dVMhWDpNz7VKP6DjccuWwxLVeAfDRLwEQjW0YZwg0jpkUpN+hl9Wq8hosdDl1DtYRVwSwnRJDJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e2db05-b695-4cb1-514b-08daa642e898
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 19:59:12.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrC68AnjOyvZROfGM/MUcpG81BWrGLzh5DaJf2JAi0ulWkxTO+lib2SDNfO4JtoXbAUzPiSsxnsD+QueGmR5vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040130
X-Proofpoint-GUID: Mkk4xo049BJ1lyVDMZYl8IN7HzW1AP1x
X-Proofpoint-ORIG-GUID: Mkk4xo049BJ1lyVDMZYl8IN7HzW1AP1x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 4, 2022, at 3:41 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> nfsd_file is RCU-freed, so we need to hold the rcu_read_lock long enough
> to get a reference after finding it in the hash. Take the
> rcu_read_lock() and call rhashtable_lookup directly.
>=20
> Switch to using rhashtable_lookup_insert_key as well, and use the usual
> retry mechanism if we hit an -EEXIST. Rename the "retry" bool to
> open_retry, and eliminiate the insert_err goto target.

This needs to explain "why", not "what"... I can look at the diff
and see exactly what it's doing. But OK, we've been painting this
shed for far too long. I'll apply this one for testing.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 52 +++++++++++++++++++--------------------------
> 1 file changed, 22 insertions(+), 30 deletions(-)
>=20
> v4: fix sign on -EEXIST comparison
>    don't clear the retry flag on an insertion race
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index be152e3e3a80..5399d8b44c45 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1043,9 +1043,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> 		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
> 		.net	=3D SVC_NET(rqstp),
> 	};
> -	struct nfsd_file *nf, *new;
> -	bool retry =3D true;
> +	struct nfsd_file *nf;
> +	bool open_retry =3D true;
> 	__be32 status;
> +	int ret;
>=20
> 	status =3D fh_verify(rqstp, fhp, S_IFREG,
> 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> @@ -1055,35 +1056,33 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> 	key.cred =3D get_current_cred();
>=20
> retry:
> -	/* Avoid allocation if the item is already in cache */
> -	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> -				    nfsd_file_rhash_params);
> +	rcu_read_lock();
> +	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> +			       nfsd_file_rhash_params);
> 	if (nf)
> 		nf =3D nfsd_file_get(nf);
> +	rcu_read_unlock();
> 	if (nf)
> 		goto wait_for_construction;
>=20
> -	new =3D nfsd_file_alloc(&key, may_flags);
> -	if (!new) {
> +	nf =3D nfsd_file_alloc(&key, may_flags);
> +	if (!nf) {
> 		status =3D nfserr_jukebox;
> 		goto out_status;
> 	}
>=20
> -	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
> -					      &key, &new->nf_rhash,
> -					      nfsd_file_rhash_params);
> -	if (!nf) {
> -		nf =3D new;
> -		goto open_file;
> -	}
> -	if (IS_ERR(nf))
> -		goto insert_err;
> -	nf =3D nfsd_file_get(nf);
> -	if (nf =3D=3D NULL) {
> -		nf =3D new;
> +	ret =3D rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
> +					   &key, &nf->nf_rhash,
> +					   nfsd_file_rhash_params);
> +	if (likely(ret =3D=3D 0))
> 		goto open_file;
> -	}
> -	nfsd_file_slab_free(&new->nf_rcu);
> +
> +	nfsd_file_slab_free(&nf->nf_rcu);
> +	if (ret =3D=3D -EEXIST)
> +		goto retry;
> +	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
> +	status =3D nfserr_jukebox;
> +	goto out_status;
>=20
> wait_for_construction:
> 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> @@ -1091,11 +1090,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> 	/* Did construction of this file fail? */
> 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> 		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
> -		if (!retry) {
> +		if (!open_retry) {
> 			status =3D nfserr_jukebox;
> 			goto out;
> 		}
> -		retry =3D false;
> +		open_retry =3D false;
> 		nfsd_file_put_noref(nf);
> 		goto retry;
> 	}
> @@ -1143,13 +1142,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> 	smp_mb__after_atomic();
> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> 	goto out;
> -
> -insert_err:
> -	nfsd_file_slab_free(&new->nf_rcu);
> -	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, PTR_ERR(nf));
> -	nf =3D NULL;
> -	status =3D nfserr_jukebox;
> -	goto out_status;
> }
>=20
> /**
> --=20
> 2.37.3
>=20

--
Chuck Lever



