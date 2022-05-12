Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFB6524F7F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 May 2022 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354760AbiELOKm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 May 2022 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355055AbiELOKk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 May 2022 10:10:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B8E201E8E
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 07:10:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CCiuTl024581;
        Thu, 12 May 2022 14:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VpHMIm+pnBI41CHaC3m8htQ294c/de2RdGlWWwK++to=;
 b=SRnHe32/hpoPF9e5RFe+oNkMgnTnxnK6wfOY6MCjYeJMLiIdcJrYyXwvSnfbzIZ7QUwG
 udsVh20TR06Xv99wy1Ac9u5PZT9ys1pVa2D7ntThsF2YqYb4Tp8l84926COuXdt+/D6i
 Tvu30h7g7ZqPsG/hDF9uUpldmjm0WRVSIbFyaXWcisZxsiRizUnWIVTOgG5iDtGcB7dz
 CalcxhT9lE4XdSA07OOFZooaAR/KiXsnwLmEElKa8O/NlHgarZGS08+Z18FgWyVOyGVl
 8bXLuZzJAoGU1lJXLuPwXLv9EHzUbejzS+uH0xGjBXPUcgMAOVW06kMNub0td88Qxqgs Zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0vukn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 14:10:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CDtFsJ036857;
        Thu, 12 May 2022 14:10:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6g1abx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 14:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npCeNjFWUCMBHYyOH3Wv7GjACTyoNqDxmvzfHnHYOhd+AneoSZpmTXjjaAOMVfsu5oGucmpUegGoZHNmC/J3Q9lSXp2+uzx+DRhGNlajKxniJOVVHWxssY8yDvFY60rEAe0Vp3x0YKyNm70RNWOSSkad9jGks2xb9Ik1l4HYN4GZNcyK86O/twNDM5WKGhfjRQqZ5QCGG2t/D3BgawoT8n36dDu6I8XAJrnJxC+29N8h63F0tqlHJ2HZuE4Nt2jRpWEwcm6YJsMqvQW+ZAYJGbK6B20VbkuF96oifNPDPRisfLYhwD6YHG+/ccSd+5iklz9PuXrlYwlllisZKKD9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpHMIm+pnBI41CHaC3m8htQ294c/de2RdGlWWwK++to=;
 b=N34g0h4WrV+l2R42uh0/Y0MGvZONV61PVhFNULxOK01e92uBPLYGNw7AiKnvdqKRE0Upv7uf6ohUaHH8WBuSKvEX/jGPWe18FPITllXxQbf7bB68nks3cVMyV9/OKJbxq0I0ogeJMYCl1hih/9KoviMEzXH6iVGxpT7p2kIyujs9hEisKtbDLOhsimkPbWX/nlGRFUrWOYYxKh8B/yw44GGvwN1sopsA0+MmgyWWhL6jeH8VVA1jU7a0WmFjcftVd24AzZFb80HpsltfjU/rXmMnfSA3mYvyofvBNoBVO0A9cO4b7HKHPThjHfMt30Gtdn4WYHG6xb9kJQhLxqQ2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpHMIm+pnBI41CHaC3m8htQ294c/de2RdGlWWwK++to=;
 b=uF7ni+LrBL576c+5FFQvtHpoTHjF271qz+M4IiGm32kkXKRw0olFJVCiS6UFNnj0uBUM8PaXDEcf/hO+iuT8NBmat9ADgkuP8vhvLxuVtt4IF/r5lmE2oe92g+5Fzl0xkfNno5O4RfFscDfJGZMqvLOAcGtOTMMXMSLKdpmZXCw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4444.namprd10.prod.outlook.com (2603:10b6:806:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 14:10:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 14:10:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH RFC 1/2] NFSD: nfsd4_release_lockowner() should drop
 clp->cl_lock sooner
Thread-Topic: [PATCH RFC 1/2] NFSD: nfsd4_release_lockowner() should drop
 clp->cl_lock sooner
Thread-Index: AQHYZYGBzMCqcO/9ck6D4En09EhhVq0bBSmAgABD5gA=
Date:   Thu, 12 May 2022 14:10:31 +0000
Message-ID: <5F38A591-0E85-4684-A262-45EB1113A9AE@oracle.com>
References: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
 <165230597191.5906.5961060184718742042.stgit@klimt.1015granger.net>
 <8e19f02252305f718c104d21ff1910c13eee437b.camel@redhat.com>
In-Reply-To: <8e19f02252305f718c104d21ff1910c13eee437b.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8512321f-d5bd-4950-e872-08da34212ca9
x-ms-traffictypediagnostic: SA2PR10MB4444:EE_
x-microsoft-antispam-prvs: <SA2PR10MB444487D2A340535DF1884AF693CB9@SA2PR10MB4444.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DY+gdvnosNbFKaz+cDsVENo+VLSzg7rDvNkgq2ihaOEdmsPLpx1bmVW0sA5Ca2FT8rsGWyypwTTF4XeEfgQzm+6DJaqYerSwuLEtROY+TzY+fJJLc6cdzIqsJH7VYYlWvJSiyI0N4AkW8Fb6WFhi24PMa/JYq26j9mpTEOd4dArz917Eo1Od810LZ9IHy+ZOkpdCaBLbI6FvhbbGrTRxO9Akrv64Y98zlYKtR+/4uXHF6x5yzjBgWY3CfZ4PTAsC5l9qGoQXEIQcGly6GiTsHBN1fgSQS5/779ct9jDwpVP3LMpHN9beS8iPNULBbeLV/yH9sJ8ddVkzlVVuy6pyITeb3KpydAI0lDLuTlJsXsQIN9HdCQvQ8lGlk3T3JANyLo02OmAg5L8qYxbiltSZ9Zfv/gqmWAVKHNzEuknMCZ/MgiwiU1KSvPHyDpnxRu2moIPcKD+K4Uf1j/VeQbXSjSWWUuBYkeTNd+BQWenmID80RPr2P6qDOFG1XWCIz9RZJoDg4gmDGiHhbOlbe/UghjCYDa/14aJE5YGocclCZHifFc3rJts+H9rGpwjqk6K24kY30ILaEL8ckbCFnaCq0XBnuYAP9yWGfMmFc9X8sKjAUr4GQB2UqW+CD8FPLQ7sMoiAvRZuKurguKGzgBRjnh7pQMq+ctlUonirvtMvIlKm80ak4N+UzjVvms/g97Y4QjDKwoq/2oZYvsZDP9ERtDJEbEjyyKlXHwZVkI1n7IKFRTq+eXFDkp2+MR26juTz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6506007)(53546011)(8936002)(6916009)(71200400001)(2906002)(86362001)(36756003)(5660300002)(508600001)(2616005)(38100700002)(38070700005)(54906003)(122000001)(33656002)(316002)(83380400001)(91956017)(76116006)(66946007)(107886003)(64756008)(4326008)(66476007)(66556008)(66446008)(8676002)(26005)(6512007)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hNXsQxLG3wE01sYsaEOM7JkLA0zhEZMA91i0qt5Usc/Q9sP+X4PJCVO5OtDP?=
 =?us-ascii?Q?X0J+hsOz/I+JgqunnXyCfBQuU1q3kfH1arNN3J856GXuJRp/oESJkyitf3/H?=
 =?us-ascii?Q?8QtEcaYn/YZnRPuIntfEqCRLlkWv/jk0GoRLDB88g/nu0bSkRF5FQYNxKPsi?=
 =?us-ascii?Q?/LNVFJFukcWjxAwhixEcxsSeSTKYbeml9Mrz5Pfs3VIZpcz8PMk2TOyY2pjG?=
 =?us-ascii?Q?fnhCft3EI6o3mYUzM1EjRCebWcs0BOYF+pgwSE9AopK2dgHHY0les6178Tbx?=
 =?us-ascii?Q?fQFbGsLQ+fwLiCh6DO/ejrkwUQBOT6D9ooFzyYC4pIojq4/ZkHgFDZuVq2qd?=
 =?us-ascii?Q?sVJWPmu06KEp2bwZTUgGq++WYmekjURNQZ4DH/32amDDrqdNx7vmn9CZgRsS?=
 =?us-ascii?Q?9JhVeegndTKnf0Y7XJH8hgp5YqnMDUsIV88orrM+MsXxKlvOxxtvWxs9XC15?=
 =?us-ascii?Q?JvhAsjd8ni3o54cNbyvvHeJXaDU0BdncvJXM/VAQAkANBnc5f80utp+wH87/?=
 =?us-ascii?Q?Pmh4fWSFdmet9TiGyF7ulcfv2CD0ykJjy+YnCVGn1IHGVYr2KcQBRzGNtScd?=
 =?us-ascii?Q?HhUhA3/ojkG8QrUm/1DwqD/r129KNfsmnjsB90OQ7IyXS9IAQCXHuZiKNZkZ?=
 =?us-ascii?Q?vemzJCBufyT/n38vnUtGMspBmJ5F+aYSqtq13DjRGPCxjH6/FTwYZRpDsS6/?=
 =?us-ascii?Q?c4UisMICGln4fxUkKM1iKb88/nVvDD3ofwohqeUCzKngo/wnLQQlkUOhb95b?=
 =?us-ascii?Q?0pJ8U1N+8W1RfW9mHO3cMD0BgF9m6t6uyiTeaKOJ30sIIhb1L6uHRMcvKNc8?=
 =?us-ascii?Q?K6rsX1AQNwUCEMWUEDFIXnVEqmUijscSx54wAFp5L7SrWyNBb5EAoJDJWMNV?=
 =?us-ascii?Q?6RXHemZs7WvLRiomGl/hMmEZCSFs+IE3mtO2zc93islXhFCiHCzkBncXa6lI?=
 =?us-ascii?Q?QfczxKkPwi0zww/vB2rxe1C5iD74sTaWUSzq9GYE16WdlrslQRrHeRn3t7PS?=
 =?us-ascii?Q?PvXQGG8POvmX//N45CTkaxIG95QZEdwwK0wFY6pUicwOdWoyNzoj/8FFbtyg?=
 =?us-ascii?Q?XJS5xQoH+VFvGMBfKKGca+p8voJCzAKul9ekQBzZW/P2X1yECd8F1hZJGHKM?=
 =?us-ascii?Q?amR20wwh91OKPeQatLU0t4roxTlqraguZZbuseKmYlX1XcURbvZOhx2BT6kX?=
 =?us-ascii?Q?6m5HKUCQl6lU1u98CgoRtbnR8QtSTB135Tg0JH0e8vUTjFbH3CPi8r6vtoa/?=
 =?us-ascii?Q?YHreqhfxNNODTK659PLF505DWKRegZJjAbCyot4i5rbccs6GlkLHko3rUlUk?=
 =?us-ascii?Q?itwwsgRDyzllroc5gbNdJxKkcYmcdzl0pV5kKDgl6DIiBIX6BEEQdJXbxPBQ?=
 =?us-ascii?Q?XqBkdhBqo8adAW6FMjjf6Vcn1OFq+i4ruGBhrxZXlT6VYmhfCFz+MPCFffV9?=
 =?us-ascii?Q?4gdD4Pf7gQh6bD8aNpPJLgzieedbRBsTb56rJU4HWOi6Pn/Ls1/6V7zPfguq?=
 =?us-ascii?Q?sGS1aLphab7fnxn8XJk1eZpNlYLQOzDjoVdrGopzz3qWoen9XdLiL6gXlW5l?=
 =?us-ascii?Q?qKDhT4tebXgXnKXDjoaajV+rOttanTXSUwg3CXKXY/wocB6LZJ3o7hXitBOZ?=
 =?us-ascii?Q?gTar//znGq33nnkqheg2Qq6Wwc6yiAK5bLPcO+nJGDnG5p4bBQ5K8HYJG2UL?=
 =?us-ascii?Q?uUFQyyrHwdCUL33ANZqAHCUednxvizjSPxksbaS6WhcBk8DjpLDzNyMzAWNf?=
 =?us-ascii?Q?/zBrlAlQt5UXvGTe/pAt9LiJ51GrT5k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FF63BE8B79E1445B946E084DCF39B32@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8512321f-d5bd-4950-e872-08da34212ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 14:10:31.3619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +159OixzwDeEYSiPhBr9jfd7R0BBAtNacBnvvPLlV0T4PlqaKph7k1brv5nT61KF5pT+b3oced3mTN6lzyXGTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4444
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_06:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120067
X-Proofpoint-ORIG-GUID: eMOz5m7yHICupkegCXUc1aAcn97SnvKD
X-Proofpoint-GUID: eMOz5m7yHICupkegCXUc1aAcn97SnvKD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 12, 2022, at 6:07 AM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Wed, 2022-05-11 at 17:52 -0400, Chuck Lever wrote:
>> nfsd4_release_lockowner() mustn't hold clp->cl_lock when
>> check_for_locks() invokes nfsd_file_put(), which can sleep.
>>=20
>> Reported-by: Dai Ngo <dai.ngo@oracle.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> fs/nfsd/nfs4state.c |   56 +++++++++++++++++++++++----------------------=
------
>> 1 file changed, 25 insertions(+), 31 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 234e852fcdfa..e2eb6d031643 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6611,8 +6611,8 @@ nfs4_set_lock_denied(struct file_lock *fl, struct =
nfsd4_lock_denied *deny)
>> 		deny->ld_type =3D NFS4_WRITE_LT;
>> }
>>=20
>> -static struct nfs4_lockowner *
>> -find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *o=
wner)
>> +static struct nfs4_stateowner *
>> +find_stateowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *=
owner)
>> {
>> 	unsigned int strhashval =3D ownerstr_hashval(owner);
>> 	struct nfs4_stateowner *so;
>> @@ -6624,11 +6624,22 @@ find_lockowner_str_locked(struct nfs4_client *cl=
p, struct xdr_netobj *owner)
>> 		if (so->so_is_open_owner)
>> 			continue;
>> 		if (same_owner_str(so, owner))
>> -			return lockowner(nfs4_get_stateowner(so));
>> +			return nfs4_get_stateowner(so);
>> 	}
>> 	return NULL;
>> }
>>=20
>> +static struct nfs4_lockowner *
>> +find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *o=
wner)
>> +{
>> +	struct nfs4_stateowner *so;
>> +
>> +	so =3D find_stateowner_str_locked(clp, owner);
>> +	if (!so)
>> +		return NULL;
>> +	return lockowner(so);
>> +}
>> +
>> static struct nfs4_lockowner *
>> find_lockowner_str(struct nfs4_client *clp, struct xdr_netobj *owner)
>> {
>> @@ -7305,10 +7316,8 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>> 	struct nfsd4_release_lockowner *rlockowner =3D &u->release_lockowner;
>> 	clientid_t *clid =3D &rlockowner->rl_clientid;
>> 	struct nfs4_stateowner *sop;
>> -	struct nfs4_lockowner *lo =3D NULL;
>> +	struct nfs4_lockowner *lo;
>> 	struct nfs4_ol_stateid *stp;
>> -	struct xdr_netobj *owner =3D &rlockowner->rl_owner;
>> -	unsigned int hashval =3D ownerstr_hashval(owner);
>> 	__be32 status;
>> 	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>> 	struct nfs4_client *clp;
>> @@ -7322,32 +7331,18 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>> 		return status;
>>=20
>> 	clp =3D cstate->clp;
>> -	/* Find the matching lock stateowner */
>> 	spin_lock(&clp->cl_lock);
>> -	list_for_each_entry(sop, &clp->cl_ownerstr_hashtbl[hashval],
>> -			    so_strhash) {
>> -
>> -		if (sop->so_is_open_owner || !same_owner_str(sop, owner))
>> -			continue;
>> -
>> -		/* see if there are still any locks associated with it */
>> -		lo =3D lockowner(sop);
>> -		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
>> -			if (check_for_locks(stp->st_stid.sc_file, lo)) {
>> -				status =3D nfserr_locks_held;
>> -				spin_unlock(&clp->cl_lock);
>> -				return status;
>> -			}
>> -		}
>> +	sop =3D find_stateowner_str_locked(clp, &rlockowner->rl_owner);
>> +	spin_unlock(&clp->cl_lock);
>> +	if (!sop)
>> +		return nfs_ok;
>>=20
>> -		nfs4_get_stateowner(sop);
>> -		break;
>> -	}
>> -	if (!lo) {
>> -		spin_unlock(&clp->cl_lock);
>> -		return status;
>> -	}
>> +	lo =3D lockowner(sop);
>> +	list_for_each_entry(stp, &sop->so_stateids, st_perstateowner)
>> +		if (check_for_locks(stp->st_stid.sc_file, lo))
>> +			return nfserr_locks_held;
>>=20
>=20
> It has been a while since I was in this code, but is it safe to walk the
> above list without holding the cl_lock?

Shoot.

I thought holding a reference on the stateowner would be enough,
but looks like everyone else holds cl_lock. More chin scratching
and caffeine needed.


>> +	spin_lock(&clp->cl_lock);
>> 	unhash_lockowner_locked(lo);
>> 	while (!list_empty(&lo->lo_owner.so_stateids)) {
>> 		stp =3D list_first_entry(&lo->lo_owner.so_stateids,
>> @@ -7360,8 +7355,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>> 	free_ol_stateid_reaplist(&reaplist);
>> 	remove_blocked_locks(lo);
>> 	nfs4_put_stateowner(&lo->lo_owner);
>> -
>> -	return status;
>> +	return nfs_ok;
>> }
>>=20
>> static inline struct nfs4_client_reclaim *
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@redhat.com>
>=20

--
Chuck Lever



