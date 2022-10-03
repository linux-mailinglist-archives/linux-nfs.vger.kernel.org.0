Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52BF5F30DC
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJCNMy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJCNMd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 09:12:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E44F197
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 06:12:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293CJ5A5016881;
        Mon, 3 Oct 2022 13:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JMJpwvzUgW1T3ZmZxazgpOzFcVpJIkGc4VdTGUoAnZo=;
 b=CivTERCNgOEwJp0FUGhB+MfG3V7rZglqqRdNbImbK5Wk/wG94S6u9R240T3+dIeKx6dK
 O3Qiy8oGz3vsfUgyJQt2gGIq4a0lM8YpcAoam/g9c8oZqaHxLGtXZXHPqk0KxmgJ6s9s
 cpaBvL8i6lgsFbIE0FyfS3DnTy+6fghxotxs2yYIM4L4tKVf4eAN5GkTm7vn6WaXrPL6
 c/87uvhMl8utrz8lc7S092DkV3WJFp6O+FPXt2PXHSLypNbebml6lz5UAKHXnF3pyO2d
 LPJFXZvUU8bdg8h3q+Y1k9/NcjwtvJ2084x11eMDIHANvFU5y9pKPHVspjuHGPmqUUaN SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb2kjg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 13:11:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 293B5ASh024865;
        Mon, 3 Oct 2022 13:11:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc02yh3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Oct 2022 13:11:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1BBRfUHn8P2L7LnObc5rlkt+hN7sz5qGb1SGliwiI65geDcXLSQkaLz0fBYESNTDEXv8mTDqm84PoAnCnxKFkSaWkWNCThp9dJNgFYzoBCJfD4/Y/qTk0ZDQ/HoHbFAjqFfk3MfALQ0+I8DirLCTjm87UE1aLwLno1L8d4laaYKwaEhERJ4ZjQUTAC9X3OtAC9laWqE7+J6KfB+hSFugbxlkH+0A/ccFSEyASFPHfENqFK1la7PcSnDC+//iFrbMDTbA89vJcMi4Z2mKLlwNv7b4MxQ7c7ccCpL72y+BoUYUTFhtO//7kXFeLYF59WI2bdWzts4jZnrY3Gys920ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMJpwvzUgW1T3ZmZxazgpOzFcVpJIkGc4VdTGUoAnZo=;
 b=h0SifNjDWX79gWhz4xqCM1JU1iyxs+WS+2ZT9Dd/ZLfXUteaQQL+/lUo619sKVUu91ExEZ3JvUBg5piCXl64FyBQ+zgJAwDucOf8CvqCcMgeSd0hHll6yvGWF9BPjXHgIFiIc3aJyRuJnRB6vl32E9miDaKq9O1QSp4fVpOQS93SdaQHRMCk9LqmcLgXRY2yhIu0nyrCk0FiNz7EPTiPRj2L4y+1hB4tTjRjp8Hd8Ny6yyUvwI+EEvDTFa7KPmGf1eUR0YCeNWnMp0fKHNhQF4uBA5zYY8Se2NHc2F+YIcxIgumhqbzlzIG8QvCxv0nuD6F/qTshBYak+ZGqIxgULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMJpwvzUgW1T3ZmZxazgpOzFcVpJIkGc4VdTGUoAnZo=;
 b=p+3mX+/GHREBsGyCYzmFAS4bgH9YZwJfPuAsmb6ukM+i5UhYIlU7QrhBXkj9uKW5g/E5e1L396jLoGcM00dXyUpn2uFC+9xob7YrVrcrX74AZh22eiHgathhe47AUxQCs7e+oiq9K7l7hVU2KToEvHZRI5nc6lWJqsm43S/Lvgw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 13:11:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 13:11:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3] nfsd: rework hashtable handling in
 nfsd_do_file_acquire
Thread-Topic: [PATCH v3] nfsd: rework hashtable handling in
 nfsd_do_file_acquire
Thread-Index: AQHY1xwiPOG/BlB/KUiRs5xLTvyF4638pTOA
Date:   Mon, 3 Oct 2022 13:11:56 +0000
Message-ID: <F4DF35B2-CE11-4BD9-8442-97852F57CE2E@oracle.com>
References: <20221003113436.24161-1-jlayton@kernel.org>
In-Reply-To: <20221003113436.24161-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4696:EE_
x-ms-office365-filtering-correlation-id: cc46e1c8-70ee-46a1-2a14-08daa540d923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNEXvK1HMIWxZWKrlDnAegqUNVQ3qaIv7Af9MYIlmDhvws3+UlzriF6sZD1ThbKdGB48T9PkLH+sX3DuqRYLUO2NO/z3cYakg07jnNUtbSWC+u67HfdBHh3f2jFbJCRvQ4ZtmKou/eK+dqbBR4dU8MrkjFwtAt4FMvtsnkKNLt/WK27lk3j3D5EzTpmI6J5R/d8R7O//4SwsJSS6AViZ3LMf+hMvJNhXm5oj14BtLmIXO+QVFTAawt+GpMpRPVAzZmEBn8sc69cMQv1IhU1M60aLlNQO2stwPZq1IuYUbnq2zmZhBm7/6MDO2ZI+EZrCfpQJV2gLUjd3NuoJVrIMIvotLxCkpg3jRaDN2tAFa1m7x4/eQBbIqiSEpJ7SxVVOv48nlMdW8DX7+bBp85etd2nRfsQo45q7ye6lRX7hc84FZV6UFan0UzpPvuCduOm5HRvsqxZfES9+aEnuBxuRlCDgaR4BMN/UYq4ZB1+XRKg47cvf1ur/hi0YUG1s0vAz/rOPRtRKX2Z1/9GrskLjh/EAkC/P1TKMnVzVHaa6NJlGuYKYneky34634CFNWwkUPTEgFwxyJe4tZj6u7t7NlvLOK7iqr2C8DcQvgCPknBp2aJSfliTZh26dBy+DJDq3ogtA+rIJwHj+7r1YRRk/UKLgsEx5Nh+CQFI8faXCPHQvHLsuyxMEMEahzLpUoGDHse1ao/xpOficFFOJunJgR5ukEVBO11ygIXS0yw9wCbyqtZO6cHiWkcooEkZoyF33VlE4ZN9T/6bV14SgHPS3JrB3+5+nIYgX2WqsCPXhD2k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(33656002)(83380400001)(86362001)(122000001)(38100700002)(38070700005)(186003)(8936002)(41300700001)(71200400001)(316002)(5660300002)(64756008)(54906003)(6916009)(8676002)(66946007)(66556008)(66476007)(66446008)(4326008)(76116006)(91956017)(53546011)(26005)(6512007)(6506007)(2616005)(2906002)(478600001)(6486002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CcdVZpi5SQEIiNA2dRFR/esopsXRP2KYMQ30BVsyO7tHY083k4RUDQr6EXkS?=
 =?us-ascii?Q?RjAVikWK8zp7yPS0SenGywZ2o6LHyJb0WJPNhCguKR8HKKctT7dHkvXBNg8H?=
 =?us-ascii?Q?l0LfUdhWiOd/g2fjJJHByqEWPp1Du8ujrsQeJMWml4NPgM29A8illmkxap4v?=
 =?us-ascii?Q?vL9vCjdBlVfGxGgGkMtBebYifStOArrk5TVVggWHU+xwT6xbRi6sVMzurlz6?=
 =?us-ascii?Q?8PMrgJmah4Vr9njvNbYfE66/ug8zHPcuoe6e+FOSCkAohfqFQ/6AuLgd5WNp?=
 =?us-ascii?Q?zWhBdUQatPWfroyeHsbl59apqr/I2N6mTx8nS+gwy4T+XyxkwrYce25HfOvh?=
 =?us-ascii?Q?lg8xKx5Swmd5jPivdyPP0FRqIkF07d7BrZmW10gdOa597Egys9K/2ri9W4od?=
 =?us-ascii?Q?JCIYruo7PWKca9aswlV+3PETP09AaCgQwiIE9ESaWHMvyLoZyPWqEsANqpjX?=
 =?us-ascii?Q?kRTmUpm629+vpCyx4Nwv0a1o4pin0QqM2e3+LYZAYj+vvq6nIxbEdzYdiNKh?=
 =?us-ascii?Q?YBdQSVzsyPdLy+j/1bRDqDRVURAU4FAC3+BvRW7QGp0ZZAJ8tSLRLF7gyNHB?=
 =?us-ascii?Q?UBbKr1RPs2z56mvggkNftHkkY+X9A406pysx4bjzRBu4AQmMSfPxnXEt9kDZ?=
 =?us-ascii?Q?rlNYi7D8v01ytaTLXlNPm3LPbjjQtdkHFkSIDxHBsFJ6FEu8YVFnc2yc6w7P?=
 =?us-ascii?Q?4SWThGWAGxs+unS8blpNEvflZ5DeiqxS4FfullP9QwskyrJC/8jOR5bSXSyD?=
 =?us-ascii?Q?2CzMndbekd9h7AYd4D7zYhabN/00VHf399TmSXc5Yj7EYVvgl4Kq584x/2fo?=
 =?us-ascii?Q?2Ip+C4uHIUb3kCUNKe4iePoC4gV1H5sKHWSjX34rwOMpVpPn8rdsHtYHhVlx?=
 =?us-ascii?Q?IP6rAIgnGHZnuMU4QgzOgtW2/Rvodd6NmHogmQy/Ps52nsKSRZ3tGCtmecxy?=
 =?us-ascii?Q?crUzYmJ8hy/WCW9gL5teqyOR73tNLJcgfZ2nQlCSZLhvXL+OGvG7jLYkwt5g?=
 =?us-ascii?Q?Qb27N8UBsNqQDtVea/Yo5VfKcpVYodTFHEdnVCNiy3e/uu0CPpp3s+k/SZe4?=
 =?us-ascii?Q?509zZp3fyB9A9O/vnpPo9XwCLCQ3dXkQWhCIsBMeiFM4a5/W0SHR/x4YXqVw?=
 =?us-ascii?Q?nUI9r5c+c6h+lohu5cXF+5/GpMVVAEP48S1yF1HqOxd+wIWBVYS/tRRpy4/1?=
 =?us-ascii?Q?CrjfVke2JkXL7j16DHKSIU/QcIkm+FACj9I19GWy1uGeHpBJ3XSUx1BQyojC?=
 =?us-ascii?Q?dBsuGhAtDIZ/T+iKRssoiNm/KGi4NbRSYYUlTL7/EzioO+wdWA8rHPGTdD8b?=
 =?us-ascii?Q?03HT9xjnbdR1X8vnIVr06AwLq7vLUm/GmUlSqONlcSiA09ERXpWimpqI6g37?=
 =?us-ascii?Q?wcwqXV0P/WNu9UUpp0P4i26eo02dYOvB1XSJTN+UlmsxiYywX2u9PUWduzHp?=
 =?us-ascii?Q?5igAogxxrAzFm6Lm9xAKwbf3Jk+cjIBjYJN9A1NcDwpUogImIWd6DcuLzDkR?=
 =?us-ascii?Q?t8JtQrbWmVkRSRXcA89Su/LxqeSZoF2ey9jDf6dQWpk8sMEi4OZJPv5xl/pP?=
 =?us-ascii?Q?UkP2aXrQ1c4EUKlI/NWiKSv8xAEj2+aZwsWQurZzFfoUWnVbAfQO5p/HWR8y?=
 =?us-ascii?Q?Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <455588D41A0C794CB9F5527B4980F4C8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc46e1c8-70ee-46a1-2a14-08daa540d923
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 13:11:56.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVrW7ZIwaZAFJ9146qISVDvslf19VPoQFMK8ZEY4Fv5a3EQZQBk3M1buqJueRiN6pIr0NHlP7b/nj6dsonH0ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210030081
X-Proofpoint-GUID: BJ1kbEGxqn_YhVg_MAfgrdyjcQhn11Jr
X-Proofpoint-ORIG-GUID: BJ1kbEGxqn_YhVg_MAfgrdyjcQhn11Jr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 3, 2022, at 7:34 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> nfsd_file is RCU-freed, so we need to hold the rcu_read_lock long enough
> to get a reference after finding it in the hash. Take the
> rcu_read_lock() and call rhashtable_lookup directly.
>=20
> Switch to using rhashtable_lookup_insert_key as well, and use the usual
> retry mechanism if we hit an -EEXIST. Eliminiate the insert_err goto
> target as well.

The insert_err goto is there to remove a very rare case from
the hot path. I'd kinda like to keep that feature of this code.

The rest of the patch looks good.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 46 ++++++++++++++++++++-------------------------
> 1 file changed, 20 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index be152e3e3a80..63955f3353ed 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1043,9 +1043,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> 		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
> 		.net	=3D SVC_NET(rqstp),
> 	};
> -	struct nfsd_file *nf, *new;
> +	struct nfsd_file *nf;
> 	bool retry =3D true;
> 	__be32 status;
> +	int ret;
>=20
> 	status =3D fh_verify(rqstp, fhp, S_IFREG,
> 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> @@ -1055,35 +1056,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
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
> +	if (ret =3D=3D 0)
> 		goto open_file;
> +
> +	nfsd_file_slab_free(&nf->nf_rcu);
> +	if (retry && ret =3D=3D EEXIST) {
> +		retry =3D false;
> +		goto retry;
> 	}
> -	nfsd_file_slab_free(&new->nf_rcu);
> +	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
> +	status =3D nfserr_jukebox;
> +	goto out_status;
>=20
> wait_for_construction:
> 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> @@ -1143,13 +1144,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
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



