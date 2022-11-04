Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27B619837
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 14:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKDNgX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 09:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiKDNgH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 09:36:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B802F023
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 06:35:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4CXifh029136;
        Fri, 4 Nov 2022 13:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GLssCySOHEwdW5DWaDqvQL14Dkwwrwc+1EQ11QW9gQE=;
 b=15UwuSf5i7CUS/EZhjBv7a8ouRr4ImrYRatww0ETUL7vqWN8vvK7VoHujl3OWVCYZhGu
 UFJQJSxjklkEuccy4GWhsPAygUXOBh232mQCEXNwRzzK2IDVNG47DjBdSfmVPfLs3Fbe
 brPFWnrLMjuCKDnDoeoxxV1nS3x9qPeTU3/8OM+oXHdhsDwMTNPK3cHtGeSyLtvyvUka
 RqXyTZlhGphkJ/rz6/qYaUHGpg1GHt4hjBpnX4DzUgYJiXILRHGSt3+yEClkAuX26/0f
 mlDgutynSoGGdF6GtOHvTCBkXyEAy4vSiC3chfLtlXW60RJUiLTycrvY1LGcnRlb5eC6 vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2aqnxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 13:35:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4CJ5Kr029627;
        Fri, 4 Nov 2022 13:35:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpr8tpg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 13:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+ZdFzBo39VlGGf9D7ILkRsDipjIhTZ6wUqKg2Al0w2X9y8SjJPuvj8FOTL+PvWMYPZNxXbwcgfru2GWMQxN79uDLxp0wyR2TGNfk7tMZ2P7Hdws0GyagQIWZNcsmNaTs1+GzsI+NiqQa/H1Iah4xQZEpGBiwuSjuPJ34e8yT5DJdOYYRe7+m51a8gaCVGSGSRSjo1jQNJaDEhQhMstIi02nV/zIz95XKBcYXUvaRob3mA4mhXNYJNpvv6jGht0KmVFw4kLzVqi+MSiydRNI5wCl4wwoLErv0R0ghtZjh76KfYAEyuMz8XXA2M17gjgbxBDQ4lZ9J9Rura3EAwo3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLssCySOHEwdW5DWaDqvQL14Dkwwrwc+1EQ11QW9gQE=;
 b=m5qSO3LPM6CkxfGfukRDJPzJ4ecELuNi5IYclwhd+wfrtU26e+JyIIlTq9/rK3Uc4Zo1XSig0gcPpfLJNQVARZ9nq+OoDP8pCjW7agQYi4iszU7ieTpfkxkx5tR7Q15k/kBy+FN101P64Cu5JttGQmUtmGCVCwQpGqJn86Wg9T5/M4zM5++lmNc0iI8b9BREQal7DxBQLGzR+/6V/Iwsom2a2GsQX8Or29L+dmUqlP6ttwQeuJccdoQXwkMcL8gjz812v19IDR8knFiZPsiEbaCtPHwyH3/NqMbI1eIDwJZoWjef3sUqxHa+78c/tkeP6Jfa34UoR46/aa1Ddi01ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLssCySOHEwdW5DWaDqvQL14Dkwwrwc+1EQ11QW9gQE=;
 b=ye456eJJN0VKVgSO6ylFTaU2WvC6EyAp+FA9WWVebuXXy0NtJcQFRu8HoERnAY0XGZevbxX777hul5EDC3WuCFDeIotAi7gS3fnTss2eesGYjBoti8icb8Jw8W4VwNCa4LXxlkh0aY5Cneh5zO9cOVsRhNVc6zc88Cxa7yS9Tz4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6113.namprd10.prod.outlook.com (2603:10b6:208:3b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Fri, 4 Nov
 2022 13:35:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 13:35:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@poochiereds.net>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] NFSD: Re-arrange file_close_inode tracepoints
Thread-Topic: [PATCH v1 2/2] NFSD: Re-arrange file_close_inode tracepoints
Thread-Index: AQHY78ITa0OizefgG0GtSGrqFCd1Kq4utsMAgAAOaAA=
Date:   Fri, 4 Nov 2022 13:35:47 +0000
Message-ID: <46A1D342-2F9F-41EB-B74C-7D894E483400@oracle.com>
References: <166750689663.1646.10478083854261038468.stgit@klimt.1015granger.net>
 <166750697425.1646.11770177003223505657.stgit@klimt.1015granger.net>
 <f2118a51b3ee47de1482081f88ae773c34606b2d.camel@poochiereds.net>
In-Reply-To: <f2118a51b3ee47de1482081f88ae773c34606b2d.camel@poochiereds.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6113:EE_
x-ms-office365-filtering-correlation-id: 5e008f96-e4cf-407f-0013-08dabe697af9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZpqDrHuslJC66aGGsECxUs196UGvHRYWG2lD7UVCshEAY3Lyq2khAZKU0saHtjB9FmNB73ZybcGX5ZUPlRcQsKOSOMp12azvx8impGljI+Z7ff+BbhkFi9ZcUBcziWPXK7P/zwNkYd5epP74BPnfjw36ESVZMaHxflTWnvwJBTE63CuHYkviHfM1KV9DU85Og0I5GAEgllVtGtuvkZee/WSGMamhXuvOfpTJ6jaiOCFtSRrtBd21GK5qwObvP31PfXJT6XZU1LhAT8DuI+9kUivP7ZTf83QJjlKyyPjk15tZUCuOk1GPlsvjE8nWPVEIn0vJvhB1MyIyppcdFosK5o45qqZCou97XMXusUG/MtkHw9xPalMQ3cP+hT7DCiDDORf2tE/ygcX0HPJhx+0+WAVb8qZvE3rlkKPqwrCXDXWXsLRCLS6SF5MgwHNsmZWuG6pXDMgodPhwZNzDSR5p4K5dcBjoB4fvChAOIaT4qZ4CrWE+YRdmhfSxt+0LJs+Thr9H1f5ETG0SmIbWx/HWsHgLqQoUJCEuLUqe8v0OEdl2xLkc69t9GgagrhcxVPAgexmhy3bIBx/28OroEx595qNy9kQQ2UAiDviUi6Q7pNT75mTsWQyFpeedjEWEIwwPomi5eyr00rKMVOen4pn2rRkjWqiqZnEqgrkNeyyZqwUcFFUZZBWLzm/bpp5yiEViJpmfLxOZ9d9qOt3kz0hk/2y8/CmQhRnRrpt0zqM05oMuD+cVSXehdy3aNABeQg0AB1dEaYTeAxYqsCWMY/ETcl1RT3GBW6FsGGnV2/ifwUU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(2906002)(83380400001)(36756003)(6486002)(71200400001)(6506007)(5660300002)(33656002)(2616005)(478600001)(186003)(66556008)(41300700001)(8936002)(86362001)(91956017)(66446008)(6512007)(6916009)(38070700005)(316002)(66476007)(4326008)(66946007)(38100700002)(64756008)(8676002)(122000001)(76116006)(26005)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CcHR/8Fg/QJ7dwlFaigAVw8ieH7d4LgiKsW5egIHMrDfdFC/h7GnKT/kL0cT?=
 =?us-ascii?Q?JEmlJtgXaRfXCQo10UKZ4knk2mYTi+2CWYIlaGXYq7b7lZLG0HFydjM8nVG1?=
 =?us-ascii?Q?GR3+mmU7C40g2FpC55vcoP3XE2x9FdBo1k5+i5WIavB5mQbq5e3OSFrTSrMb?=
 =?us-ascii?Q?w3ScHekFWzCsCldQFtIRzUqv/xS4OL4wjMCfpdZo4Sha4HgGse0/Y9CrEVtS?=
 =?us-ascii?Q?weJJi5xFVN1cTSFlR8qieC1k9c05ZjUIgZiSY1x7agdikL+9xwwKP169X8rE?=
 =?us-ascii?Q?b5lN3oxhUi7+9LFFKTkvkqbFWbSE9ktzXaF79jWMgZE1nuZJwPsxiPOe6lMR?=
 =?us-ascii?Q?Xr6hVxOux74ui4ASrdNUDpc7LlzmbOXNfjbQnXPMu4Y/0ZOr2pcA0jMJMy+m?=
 =?us-ascii?Q?+BZFd3rfuZDlJyamzIoziM9GIjcCNUSU+GgjlkGVVBAPQjBlSRZ9HrETokHu?=
 =?us-ascii?Q?sTYokcpaiOnB6eOEXUkcwuke+s9dDBLkx2h806O2zEbsd1PXUBZiiIboqy0P?=
 =?us-ascii?Q?RQxkJi8TpnUSHZMej5d6n49Cu/ajllFL5lqOVkuNQnWBroJLtCu5/I+c4QC4?=
 =?us-ascii?Q?F38dOlN2cncL2HBre39ca4oJPIYheOQ7j+zo5gaZ8oi3kJd0UGfMKDSEfAi2?=
 =?us-ascii?Q?7C0qOX1fNvYH4VJOQqZMPfsmQ1tPd4oeuAU96NQOa6a2P1lXGBt21FKvqYVQ?=
 =?us-ascii?Q?zN6r52K7sBNLHmwdoZsu72GshbpLG999v9T429j7pWYekd90RJ2JrfIioBs0?=
 =?us-ascii?Q?xMXOgRIJXdweViKYa54TaZ/jke4VF4zlxo0s/X4dcocBnAV1UfaBpxWb8CPj?=
 =?us-ascii?Q?QNbBMXrVv1cESJhPBFWlE+eza9NoC262U6Updn+MbaCkbORsiQwoRU6qz2ys?=
 =?us-ascii?Q?Plw+TlSN/DOSERV53bKAg0EGPkXDVbMNbeHYNXw+VaJyU5oI0YZVdIuQQjHn?=
 =?us-ascii?Q?aDzbxw2K93gNO9Fg5hjkPZHBjYdAlifa1GCEQFo4coJb1LMAJfQPx475riNC?=
 =?us-ascii?Q?bjXTEvz/R8NUBt9J6/75AR5DoQut2T8AnpUpt4fWQVW6M/fpEli9IH0KvrPT?=
 =?us-ascii?Q?3OMOyK4B8WVX3Wt7j0c23M2qz1g0tz2lhTfOtNTSg/hHzw9KB0/zvyf0lwk0?=
 =?us-ascii?Q?EUmqORPEUs/FL8bfrdpw8Sta8ASOGIM0COBFCJ1V7aslmFqHpWFpxmnxLPi0?=
 =?us-ascii?Q?fGagMmiSrghwZgXv5H2yalYN0mNcbAq90H2JV/YrXjeqnPWadukXmAKjMlik?=
 =?us-ascii?Q?AbhANvplYgHn5kNPGI76GB23yxgPS1KzpHEgAQJAI9ihUKVE4hG4xa+iuXUb?=
 =?us-ascii?Q?tryI+v+bcCkvt4ZKFEWfjabJC1qMuKpPabgWkNs5Pp2ADAX1xTRigBWHqrLp?=
 =?us-ascii?Q?OGDd3GwyMVgSraWzwgaKwq60bBZOxj0cRZqSe0zYKHH0JM9oo17Oxi0XfWWg?=
 =?us-ascii?Q?KUWnMK5xFkn68MdISMnSzi21RjtA4izRmb1lgb3r5HSdUcHEm7bu+NXGtot8?=
 =?us-ascii?Q?bE7zeD4/z8bhu48tRbfrGLL9/2rHNDjV0FSPp18s6ZiNtxSsl/PnCDisHVDI?=
 =?us-ascii?Q?NXiYX9GWZrN5pcEULk7Y6RyY+YYTo6IPXQutRTnAUbB9bSk8xDYW6C5G8sn1?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8DD5B17F6A9664D961DE2119D055A96@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e008f96-e4cf-407f-0013-08dabe697af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 13:35:47.0172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0cuYVDqZJK6nIpxjvyAdSIZgAiCHr45nuuSoOo8oasiD4/Xj1YooOBRUNykYWCrWA2wMO8jV+k81PVi6ACzow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040090
X-Proofpoint-ORIG-GUID: Q9aE3RtbFww1YeQ6EGBnTxmwO3gwD9Sg
X-Proofpoint-GUID: Q9aE3RtbFww1YeQ6EGBnTxmwO3gwD9Sg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 4, 2022, at 8:44 AM, Jeff Layton <jlayton@poochiereds.net> wrote:
>=20
> On Thu, 2022-11-03 at 16:22 -0400, Chuck Lever wrote:
>> Now that we have trace_nfsd_file_closing, all we really need to
>> capture is when an external caller has requested a close/sync.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/filecache.c |   17 ++++++-----------
>> fs/nfsd/trace.h     |   45 ++++++++++++++++-----------------------------
>> 2 files changed, 22 insertions(+), 40 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index cf1a8f1d1349..7be62af4bfb7 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -706,14 +706,13 @@ static struct shrinker	nfsd_file_shrinker =3D {
>>  * The nfsd_file objects on the list will be unhashed, and each will hav=
e a
>>  * reference taken.
>>  */
>> -static unsigned int
>> +static void
>> __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
>> {
>> 	struct nfsd_file_lookup_key key =3D {
>> 		.type	=3D NFSD_FILE_KEY_INODE,
>> 		.inode	=3D inode,
>> 	};
>> -	unsigned int count =3D 0;
>> 	struct nfsd_file *nf;
>>=20
>> 	rcu_read_lock();
>> @@ -723,11 +722,9 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
>> 		if (!nf)
>> 			break;
>>=20
>> -		if (nfsd_file_unhash_and_queue(nf, dispose))
>> -			count++;
>> +		nfsd_file_unhash_and_queue(nf, dispose);
>> 	} while (1);
>> 	rcu_read_unlock();
>> -	return count;
>> }
>>=20
>> /**
>> @@ -742,11 +739,9 @@ static void
>> nfsd_file_close_inode(struct inode *inode)
>> {
>> 	struct nfsd_file *nf, *tmp;
>> -	unsigned int count;
>> 	LIST_HEAD(dispose);
>>=20
>> -	count =3D __nfsd_file_close_inode(inode, &dispose);
>> -	trace_nfsd_file_close_inode(inode, count);
>> +	__nfsd_file_close_inode(inode, &dispose);
>> 	list_for_each_entry_safe(nf, tmp, &dispose, nf_lru) {
>> 		trace_nfsd_file_closing(nf);
>> 		if (!refcount_dec_and_test(&nf->nf_ref))
>> @@ -765,11 +760,11 @@ void
>> nfsd_file_close_inode_sync(struct inode *inode)
>> {
>> 	struct nfsd_file *nf;
>> -	unsigned int count;
>> 	LIST_HEAD(dispose);
>>=20
>> -	count =3D __nfsd_file_close_inode(inode, &dispose);
>> -	trace_nfsd_file_close_inode(inode, count);
>> +	trace_nfsd_file_close(inode);
>=20
> With this change we lose the count of entries on the list. That info is
> not particularly helpful, but maybe we ought to consider a tracepoint in
> unhash_and_queue that records whether a file we found in the hash got
> queued? It might be nice to have a way to detect cases where we close a
> nfsd_file but the refcount was >1 or 0, so we don't end up queueing it
> to the list.

Would that be an exception case, or an error? I'm assuming the former.
No objection if you'd like to add that as part of a follow-on series.


>> +
>> +	__nfsd_file_close_inode(inode, &dispose);
>> 	while (!list_empty(&dispose)) {
>> 		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
>> 		list_del_init(&nf->nf_lru);
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index e41007807b7e..ef01ecd3eec6 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -1099,35 +1099,6 @@ TRACE_EVENT(nfsd_file_open,
>> 		__entry->nf_file)
>> )
>>=20
>> -DECLARE_EVENT_CLASS(nfsd_file_search_class,
>> -	TP_PROTO(
>> -		const struct inode *inode,
>> -		unsigned int count
>> -	),
>> -	TP_ARGS(inode, count),
>> -	TP_STRUCT__entry(
>> -		__field(const struct inode *, inode)
>> -		__field(unsigned int, count)
>> -	),
>> -	TP_fast_assign(
>> -		__entry->inode =3D inode;
>> -		__entry->count =3D count;
>> -	),
>> -	TP_printk("inode=3D%p count=3D%u",
>> -		__entry->inode, __entry->count)
>> -);
>> -
>> -#define DEFINE_NFSD_FILE_SEARCH_EVENT(name)				\
>> -DEFINE_EVENT(nfsd_file_search_class, name,				\
>> -	TP_PROTO(							\
>> -		const struct inode *inode,				\
>> -		unsigned int count					\
>> -	),								\
>> -	TP_ARGS(inode, count))
>> -
>> -DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode_sync);
>> -DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode);
>> -
>> TRACE_EVENT(nfsd_file_is_cached,
>> 	TP_PROTO(
>> 		const struct inode *inode,
>> @@ -1238,6 +1209,22 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
>> DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
>> DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
>>=20
>> +TRACE_EVENT(nfsd_file_close,
>> +	TP_PROTO(
>> +		const struct inode *inode
>> +	),
>> +	TP_ARGS(inode),
>> +	TP_STRUCT__entry(
>> +		__field(const void *, inode)
>> +	),
>> +	TP_fast_assign(
>> +		__entry->inode =3D inode;
>> +	),
>> +	TP_printk("inode=3D%p",
>> +		__entry->inode
>> +	)
>> +);
>> +
>> TRACE_EVENT(nfsd_file_fsync,
>> 	TP_PROTO(
>> 		const struct nfsd_file *nf,
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@poochiereds.net>

--
Chuck Lever



