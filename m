Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203065589DA
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jun 2022 22:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiFWUMH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jun 2022 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFWUMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jun 2022 16:12:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A34FC6B
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jun 2022 13:12:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NHG1Td003244;
        Thu, 23 Jun 2022 20:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=B2qOxkNFcruHr/RC4yktH1qhdtyNTRPRZ5DMBy4naOY=;
 b=EPWfPOyhuHx1dOLLfU5xxCpntT52oIn8mx0PLvyjeWOJkM86vUsY0nHZvdY+5bhdX9gL
 B41zwYhWd9bLUTW7IYQuMcYyvl3nhvcGitljrchPw1hbGr2uxsZczGH9k8Vw1qG+Irij
 BCB9ag8TzCqhxvUpAi+YQT8+Ua548kmXIBNEqpJl4S90hymoY0U6gFWsN5XGKqHgMUZj
 FPbi/Hs7apLp2Sth9t5xFdvTu4AlwFXSYuqZtVGOCnLkwC9yMnQBZBjuxuFfGO5fgFrB
 WFI7bql9kPy67RGU4lhirAFqendgPNu3yeNnc1oPP/ihOG5ACbB4puFiDmnux+fh8eDA Aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u45nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 20:11:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25NKAc0i019027;
        Thu, 23 Jun 2022 20:11:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8yw8ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 20:11:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ7NnUKMX0xzsV9FYeiU+i3naQePUhOLCfhy11KlrAMb7EYstyZU4cFfrzpmtm3p3TC4sZAoRuQlB/BJ3m9PQWUynjyOHsKw+YySuKgc4tqXc5LCyIsCi+s1eNE2tWTmVGTby+4NQVo7p1Ei33D0zCJzY6lEEWcZ6AmQTkVJMQ/NcRVLAch1oIdHtv8tq9mIchTSWQyzJfc/0leg3m2fzC+KjLcnFuqGESLMKXWVG1x/nTPuO3IiSCmOS6+hgq94rsz3AjJJNvkn77abVrz/mld4Z6LT2KUOKgHTbZUge3Wc5lNzOxBggx0/d9NffC6ZSCTnm1qsqATQ7H3JQi+Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2qOxkNFcruHr/RC4yktH1qhdtyNTRPRZ5DMBy4naOY=;
 b=QC26GJUCRYJLbbjHK3W1GQqDbZAlWRRr+0XAKqHDIur8CuaDZfhmxPSQmaQQEdR0W/iBQD+QfcwjTfbDwefKM7rC2Ew2yrk83QLe/7bVJCduMJISIyveDn3KNCt1xZ/sqHuWGq11pJFNbjjoq9DoU5OV6jWvFtRfUSb/gdl4Pl8/mDQcdVoZ7acfrThokoDyBIyq50BTeT/cihG9yP/HJPMOGyXsTxjlBpu1S5XcWnYw45YPBFdw9tix+NPf62E2/1/x/XtySdg4PBsC7j6v05nfOW9LtFb78iLekWRLdY/dAmvSyYM6xnnt7EzhzN+5meMdvdY9CjsHpvqFpuopbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2qOxkNFcruHr/RC4yktH1qhdtyNTRPRZ5DMBy4naOY=;
 b=ETilHtrsiI1p8yj0yhg5xMKIVZ8kp/T2uTHbf1Q3+SDorAnIKsI763u+6d8vtKiphCy5hX9uxokQwW97HeS+OlV7Va5TlhRQgjCC2FmazsTeIe5U9/ndOk1HJjYeRvqwV1DNtm1B3I8e9hIQBgVjTKil7QmgE/b+YdMhPS86dio=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DS7PR10MB5007.namprd10.prod.outlook.com (2603:10b6:5:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 20:11:51 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::c952:6550:162d:4aa]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::c952:6550:162d:4aa%5]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 20:11:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: restore module put when manager exits.
Thread-Topic: [PATCH] NFS: restore module put when manager exits.
Thread-Index: AQHYhrxhHae1YJ8NFEO69Q/BlZq8nq1dbXkA
Date:   Thu, 23 Jun 2022 20:11:51 +0000
Message-ID: <34FB98B7-1F1B-4901-B2DF-442B7F212F76@oracle.com>
References: <165595965412.4786.12578338276708392878@noble.neil.brown.name>
In-Reply-To: <165595965412.4786.12578338276708392878@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 747d9078-cf73-41c5-8198-08da55549c31
x-ms-traffictypediagnostic: DS7PR10MB5007:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H1fEGYDK7mip/bER3MA+zT7MfoUDACSTJDoGXTav+YxDYm7oyKvZ8kRI506/3YMW7bsXBRgxHfFzAOHUkO5ezEsIVlBywJ7jpS1m+KYjCX8Ws5D5gpsStUkAKlhm7YuWiyrR3G0hWr7JsdwQ3sm/WzfwahUbGlihgL+FetrbMC73GYxOF4CFUkvJQkB6qIiGhynY5Cvy7EMIWPdbjqgUh8x1Jo9eUhAR0yRBNqSdvW5hzUXG7+NzNmxzt3K9asQ1i0a3LVXOP8joqBcLgcI6NEMx4ILyRZJkY/twFa7AYdGJa5yfXMWL+zQWewLHKEQlu6mA1lSqrZ0nz757pBSH/YzQkx1g1nk1eVh82uDXPBbp2o7EPrLagqcdCpoKAKT5YpIPrhxgnJOTSWYBVlP38EFs2GMabp6ceJayPP3///iufRXZLfMH84JMfKoJ1YFkgaNRjrLeOPD+7CHwCxf8LbT2ye2LTfEyQ9a9hk7IeGNJwypvxhoctEQslTElnSzMBEAHIklAsxC6xEK0sDbI9TIuTB0x9ERIGcANMC/Fh4eGsrqvqfiOl4SenVjVF7uKFjifPhuaT2KkeIcno7Aso2oaThEHh7008/3+1NMUAx1mfsyw+TCCJ3WA6hpYkzyM2regD4k25vSCeh0dz3RghGav+/3v5Mbwphzwhd0qmsLgRpAOLO102jP3dp/1/4gnIhM2u1Om7mxho/5pdeWb8pkBph0xftgEypeh8TGeqJE7fXC1SYwtS8DBUFXx/Uj6ufsnRORdIqCVUvZhn0+TdlI6N/8qckUl9oSsyml1wwz6dtuT5g1OL21ZGjrlkakdwYi/DEZ3sixOAgrvv8iz+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(346002)(136003)(186003)(8676002)(54906003)(36756003)(38100700002)(86362001)(2616005)(66446008)(38070700005)(64756008)(76116006)(66946007)(91956017)(4326008)(71200400001)(316002)(6916009)(6506007)(66476007)(5660300002)(41300700001)(53546011)(26005)(6512007)(478600001)(66556008)(8936002)(83380400001)(6486002)(33656002)(2906002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nasdDAZLlBGAL6uVjE7y+bRITJaV2U4qb1ZTRHZZtyxemThHYJbn6/TIPOz1?=
 =?us-ascii?Q?NgDMFAzK7zavG+7Uwtr3XKN3WbplxcEqp5MwiYAjycEZnFR4M+UDo6J5Esgx?=
 =?us-ascii?Q?bGGcuXMkbqcJl+t7YOLGRtuHCsXq5mUsjbchtnWDpBxT5AcxD+ZJmU9ApcJR?=
 =?us-ascii?Q?Ei79SM8xgmUOIhRwybdCqam2cPFccYsJhTR7byVqrbq2ToJ4WtkBVYYNPSZF?=
 =?us-ascii?Q?wQQptwi8rHlDw8oleM6n8xvzZxW+RipPdqmz3I3jpKYB9ofFAajLsxDyk8G1?=
 =?us-ascii?Q?1jRxJk+XkiuoPQOQ5DfH0j7a9z/vpyuxS7P0upffbr3Hinw76BaX2y3lYOR3?=
 =?us-ascii?Q?o/cbg36TH6aCi8WHcoSic5OOke7U7ZPZtrd27y1Q8v1OC4w8BmerGa0JlTUM?=
 =?us-ascii?Q?xZhBtm8OEyLz9Nxt0DbaHQ7ysq03+j8ngTVMbDSax279/L7A03BV7Qq2B9LL?=
 =?us-ascii?Q?ofjuuCbkgA3TmoP97XKcpPOGUcupp+3w2iHNggzQd3wm+8A26Eau/lXtOPza?=
 =?us-ascii?Q?VLh5+UQaOa9bU5DzkjSP8HPR2kGjhSZdAuYMepjPWX98c2mRNoKHwKw8fGWj?=
 =?us-ascii?Q?IY5k2QDwzy8OQWfv818wEX0EZPpL97Cudt8d784mpCBGudhSq1kzsVTlV0c4?=
 =?us-ascii?Q?GlkTKTu8Fs2Jc2XrYlwSM6VUOyrOcFBUmwVbrt7PJx3IIUEJylsp1SSJP8u6?=
 =?us-ascii?Q?qMVneqwLYnMileXQqM7ExE/1v3tUu7SrgzaSqPgibLOruvr+lDBdGd/ZT7hj?=
 =?us-ascii?Q?YOaP5Cio9/RynRNV5sWvp6jO3zKo4GG4SiPyFd6LB+1PWjspMTkyuees29J+?=
 =?us-ascii?Q?4qUk3v2tSIcFaL9erwYr1BCrxlxbOq8H2QUJ7Xih1ZTq36B9MPvXsTu6C6fr?=
 =?us-ascii?Q?tKL6lK2BYQjZhNIhYuaEgMDbDbiOS16CiJTdSo0I0/Wlwu1ghJ85erhO6uqM?=
 =?us-ascii?Q?FjpvxXDtTPNtHmy9E56M2iM1y0VjjGuqEIWOz52mKNvxSuc1DA58JP2U3N+A?=
 =?us-ascii?Q?Z09fWwqTO0B80Qzl7u2sSnwjDuw3Zkt/SlKkFqVIUpN2v4v9P6NlxaIN0Xbh?=
 =?us-ascii?Q?vtf2YHrWlZ7Lsn2EmV+XKPPpOzz8O05Kbh12KlfEMeomgGQFiFe9VJ/+qNbz?=
 =?us-ascii?Q?3zzIh3uyQ7Spqy4UJHqsuZah+3KudHBNPE1O1gR1l7xNUm+pQ5asRIaBqcVH?=
 =?us-ascii?Q?X8slvoEFawaxZkWKKiD1MgGdwNba+jQFM/NmAvewPkuw+h22s8yuNLE9urOj?=
 =?us-ascii?Q?asXp9UIQHtoA3caXyC32sP1Wx1cCfmZw+3TRRm9biSpnek1alHu2MDacwGBH?=
 =?us-ascii?Q?OdNxBwuYws7XvMmbOw36vMKMTIsN8UIjMIXAMshq9otIIUP2xpcgwETTrX1i?=
 =?us-ascii?Q?br71hLh8IVeA7cJBMvCqhPt/Ru89v3VhtAJC4KaG4JtGnMRB9JmCmvT2qoY+?=
 =?us-ascii?Q?KG1ufvgBhXcpmpoppk1gK8eKX7Mw/nYw7wtNLgBD8cs3WQr+NIksyDiwq9ke?=
 =?us-ascii?Q?NFwWqic3jn+oGfN8GhJV9pOSQRQ/opEIj5uvm3jMDeErFkw+E/Dx8VQzsMvs?=
 =?us-ascii?Q?Oj4K4cXz5/ifdAf1GckjVV/+MW+ua+3IKVJK8aRBBQBFVF8f4RjJ0+jDAibq?=
 =?us-ascii?Q?sETzb+RVTv0d3mNlUJCqxKHAXrAwvTmHj/tu7MLleT2Yr7v1rfyqQrNr04nr?=
 =?us-ascii?Q?zxMw+wV/l69Q0pjJokBW4dkCijOkde4dl4ICHkisPerkGShcnRKHRofc9SRX?=
 =?us-ascii?Q?jdJI9EvUgNQ2QYAeMrooN9zTSdc/KFs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00079FCBD3F7864286584281F4985874@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747d9078-cf73-41c5-8198-08da55549c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 20:11:51.2137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DgKj5lTMqNVpm6u5jxtJ0qdcDauay1qjG94V7kPdwvMmY9wySj66tjbMN2xYqWvmyDCuQHUz7wyvyCzpdTTnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5007
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_10:2022-06-23,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206230077
X-Proofpoint-GUID: zWEaeF4ZNsmpPoyy4PMHkemH45eUTjf8
X-Proofpoint-ORIG-GUID: zWEaeF4ZNsmpPoyy4PMHkemH45eUTjf8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 23, 2022, at 12:47 AM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> Commit f49169c97fce ("NFSD: Remove svc_serv_ops::svo_module") removed
> calls to module_put_and_kthread_exit() from threads that acted as SUNRPC
> servers and had a related svc_serv_ops structure.  This was correct.
>=20
> It ALSO removed the module_put_and_kthread_exit() call from
> nfs4_run_state_manager() which is NOT a SUNRPC service.
>=20
> Consequently every time the NFSv4 state manager runs the module count
> increments and won't be decremented.  So the nfsv4 module cannot be
> unloaded.
>=20
> So restore the module_put_and_kthread_exit() call.
>=20
> Fixes: f49169c97fce ("NFSD: Remove svc_serv_ops::svo_module")
> Signed-off-by: NeilBrown <neilb@suse.de>

The fix seems correct to me. I can't remember why I thought this
particular module_put_and_kthread_exit() call site needed to go.


> ---
> fs/nfs/nfs4state.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 2540b35ec187..9bab3e9c702a 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2753,5 +2753,6 @@ static int nfs4_run_state_manager(void *ptr)
> 		goto again;
>=20
> 	nfs_put_client(clp);
> +	module_put_and_kthread_exit(0);
> 	return 0;
> }
> --=20
> 2.36.1
>=20

--
Chuck Lever



