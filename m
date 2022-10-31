Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572A9613C29
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 18:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJaR2b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 13:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiJaR23 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 13:28:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB3D12C
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 10:28:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGwqYU010783;
        Mon, 31 Oct 2022 17:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aUmWw+PDbBNqCZ32mB6Rcrkspa4nZHHm49ECp5rDj+A=;
 b=rqjLC28ZH+IDEH/bDb7w8wAzInhKcWtKwOdnRbojMrFCLqiTxPZi/LB3n6SO6jurLQjH
 z3YBS9ffIHOWRh9K1HIL5WFfjUuRKRas0QXO//R4nbD/wevuHg61wWe8vvCzD0VZeVSo
 I0bOiCsZYZLdSs8ArSnsN2fQPBYo+FoYX583DkbmPdYffxuIs9oPkrZmELEWhHXo52UE
 uLcmYRtqDbjs+kk3kDkaJYBBqjJUCiIyIp52L83jeyoxUtNgJAVDKomkUbL+b2ivPpbr
 HWDjnKMIqRrNeVU2VREh9pjSr0S4w/yNBHZZYAo/7U8YoMf2hxvEN2cRgYwq07Lm3vMJ LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussmeuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 17:28:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VFHiIQ039633;
        Mon, 31 Oct 2022 17:28:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9jwwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 17:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrP+qDPl+XDINs6o7eQul824zNLnI2r5bdIyJPnV1r0Mi3myZ6cJ7zcyy6/MwPWPQmrlFAFcNOjOPjuzoWKMAJhGVT7lymQlkHSVRaoIRljE620OVYcSLrlEUw0u2CSNXOIohbcnk/yR2sWJFZwNsY5Gt+kxNwRqcT4/kjv5vLRmqQC1FA1G2Et9J+4aPLSrwXDPEbEJJ/+Gl0nx7I2PPXyzHKyWNzBNViEDyeT2L/XjbIM/ERlE2Kn0m84Kusl6WOHE+yMT2LlwTSHg4u+VKGEQsLxVHH+m41rtUeN8UPGbIxR4FaLQkTXcxt/v7D36kQzV9PpuQY6Areop5PCkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUmWw+PDbBNqCZ32mB6Rcrkspa4nZHHm49ECp5rDj+A=;
 b=TkeGcHl+whQEKXfzDfv+IujflVuQtkPSfQMYY9qye1txYCc/xT1fYo8nmuBENuZhCjSmBNvLmn8Pmhc2uN1v9rqbRSMZhGzjzOQ2+D/Z7LzzvkgQJ7tMdmeX+Wq97s9wTIoc4DVMaQKV+xWbPZBvMIvxaW0YuJ8D/8W39FqBGjjI4dN3Nm5cnqOJ0uqFG67LqjGiOI4Ne7Jscy59OecZSkdiQqjTh1CQ6zlmQTZX0NmwPX5cC1JaYWRRIzTBU7WDccKVhSNpKb+081gqLQDBFqqws0vnc8WEVoZioEhxMC18eJiTrhgjuCpibyFjfEF2r88Xt3EXYdIM/tMcu91tSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUmWw+PDbBNqCZ32mB6Rcrkspa4nZHHm49ECp5rDj+A=;
 b=uUSxdJeoTkHaVVTJU2bVmyEqLO4YEtULgHg5CInJloblNnNADgKCbSlYplXPu7A1bIzl2szxeMsYZdQ9MosgJBuU6bXQZyUOmCljCXA7t+uMOgJX0HTdLeEVaMGwj/JnoJHAT3+o3w2P/SqR1SyQfDPUz+r9/pV9xmNAeKKHxNs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5787.namprd10.prod.outlook.com (2603:10b6:a03:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 17:28:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 17:28:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v7 11/14] NFSD: Clean up find_or_add_file()
Thread-Topic: [PATCH v7 11/14] NFSD: Clean up find_or_add_file()
Thread-Index: AQHY6tx623edtfKYkU2VQ0hX3WF+qK4ouhwAgAAMd4A=
Date:   Mon, 31 Oct 2022 17:28:12 +0000
Message-ID: <D051BD59-3962-4A0D-B099-F50F50616BAD@oracle.com>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
 <166696846122.106044.14636201700548704756.stgit@klimt.1015granger.net>
 <d9bd2d0f17c53ce864e093324ad6ccc9de1871c5.camel@kernel.org>
In-Reply-To: <d9bd2d0f17c53ce864e093324ad6ccc9de1871c5.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5787:EE_
x-ms-office365-filtering-correlation-id: a729898e-e402-41dd-4422-08dabb654935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m98xMVyN1qvXyjliaiV2OGoPWWwCohONXY3YycAjFH2vIKUtHbZxA/yHfiP2rw272sOBmvL0igDkS2wXIaZknxejrY9OGuTcRFCpG9E8F6nVXDL2JQcaLtu6guFajMu3upv2ZRHzl08uAIlfErnCK37I/OFTa3i3Db3XUFh40pgF2+UBPHIiYzNjRx05W/E3Jg236VNyFuH1RWPIJ+AwQNcgQ77G8rKt9ZIByLpaqcHm6ckBLOvpYqtEEZVTdAjcjQs3cXQx22pjhqpoA+850ytx7zeSRb0iviZP1bXPLThKsWa/BlujS8bOOFpKeKgeDTTA4QZeRcPeUJJxqvTrwWvetFMZtphZy7sGgrXo1OypCBs6ryx74ay2buGL4vrZuw41w+OZoIb7mjX+cTNLmLY9d14l+2GeMKZjWl3xLLF0Rw1qg5CjY723ocJRgW/BPxL+qReKWe3yqJlOwDIAOQkSXkxrEWbbvHamprNhH5t3jdSWpBIliMtKWoRGHrSeE7tDKZbTPlkJJA94U4TyddEC/597R+8IItot4Un3ZVfGiV6ZwhZDj/oAaWzzbRfAFbTLy1Nx04nt7Tww5SthFVnjNoQAKnHNAK//T9ObaxTWtmbqkxERphW+H3t+0IQs1JQQSZ92JxrlZ7nPTbgMJ6ZPndt5BLrsGP7y6anBynmpQVimpTZxjOqoWGaSdg9nX8Ye+RapFd9C3chL3ARLPXX4Kr05IA84lf1EXvxsSswyO3LuCjb25pJY2gdtBWa53VL284DkNdmJwbpSKHToPeGqRYYU/MHyB7AhHe7a5Zk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(66899015)(4001150100001)(2906002)(83380400001)(91956017)(76116006)(54906003)(316002)(6916009)(38070700005)(66476007)(66446008)(64756008)(8676002)(36756003)(4326008)(41300700001)(33656002)(66556008)(478600001)(6486002)(71200400001)(8936002)(5660300002)(66946007)(2616005)(186003)(38100700002)(86362001)(6506007)(122000001)(6512007)(26005)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dc24jeiGmFbRKp8eC6xHlArcj/zp4Cgq9tdS9g4uP67waP6wW0Z3BO1qTHBc?=
 =?us-ascii?Q?ywfF6sle3KOWnoTpNDXbAXIy5NkZzROAaRK+++Q8Ngq7spIOhVl6E4K9f+6a?=
 =?us-ascii?Q?6SiZDNuVX5ExXDG2vfh3Hxrih98uhLhj37PrB8/JYij1yLJq31GZIhXS1tDj?=
 =?us-ascii?Q?z8HZ1c0EmPuPuTXV3UTB8ad43+9mVFYxyzit6n1MSudLK8nFPXyl3HUk0hbg?=
 =?us-ascii?Q?DQMoUVIrUtie7VJxYKzQxp7B7u02L2iOYmTSM1BzTvbfvEURzFVKS15LmDkR?=
 =?us-ascii?Q?RabPBAdjs5/DGhXSN0Rkb2X4ScmAgrrPrJfrd6MlNh8JfqgynPc0j/U6CA0P?=
 =?us-ascii?Q?F+8GhsQOPJ2aCa5+9FaZ73mvn7bQazCMVaVzGaxrah7lLyJR1C3jGxlS/d09?=
 =?us-ascii?Q?4kXW4ldPBA68wsW8WRAVB/AZbYfQ0VO2m/iE++YZQgvnqJSunhisa71iKKXW?=
 =?us-ascii?Q?oAnmJ04tJ4KXqMsW5hbZ01SEXUReX4Anbi+bKToPRkgBFA1CNJKOOSPgbhC5?=
 =?us-ascii?Q?3GpUV7YugnbUX18KqgjRoADeHTE6n0hRwCGgtQs9j9z3y8UpIhwO1DUW7wZa?=
 =?us-ascii?Q?3fEc3PdAYxWci2F2iVjLBNrCf1BZeVCoMK8wtazuEGV3b2XY7MyHv4ab2T9g?=
 =?us-ascii?Q?RXgmFocv1E0MDqk4i/9buTW6wfFiAS8Guk8aeMLffE+GL+pwYMA2yKbWgnlX?=
 =?us-ascii?Q?hFwQDtFtFkqQYocCzkSB2mdTY6fWjmLExCfOdV1rzmtCD5GTBGbGClz7/6CN?=
 =?us-ascii?Q?jDSU2E396qd36jYbT1ajm0XjFZ84C7b9voBf3LKXp6w/8vRgM7ET2KMkYP6B?=
 =?us-ascii?Q?Pofwcy8NLtqIaxzKwyyWQ1v5oTqN5qN1jgguqT5KF7vjuaSmnlX5hDWpb9lB?=
 =?us-ascii?Q?4JdCrD6qvHK9RIixrbSB9TZcnCgC2ET3SP6aVnSx6CC7VKSq7Ee7doHx4eny?=
 =?us-ascii?Q?Cyv+IS6YMu1sW+IZDuK7T9DtT10yIV9ppdAsZd7EHj04t+0SSW7fn1rLtHof?=
 =?us-ascii?Q?2/hCBXz1gq6xkweXpelSLygRhA5gcDThoS7OJD896Lo6mYjnzRd14oLsMVZg?=
 =?us-ascii?Q?cRnPFF/+nQWo28vuA8FQ6Q6lfugAfNGPUGl81Vmj0KHthC5viqrdN+I+f0VG?=
 =?us-ascii?Q?2bV2vvrlDjRpATFt8cBNMTEF/rd1Q20F067DGBOpvQotrmcaxT2cw9B6COAJ?=
 =?us-ascii?Q?2sBFVMQ75dEFSM7eLClANh2EG87SfRMoOvebardnhvEsjiEQNj3+7/QO5r64?=
 =?us-ascii?Q?fc6YDrX9B3n1Mgz67OgfX5tqv/EPNbtj57O8gboKplXupfz/ZKVR3Enbeuv9?=
 =?us-ascii?Q?3SmDftvzXIVXtMos2+GKXbV/dmo/Dor6FMGKb/zUEVAvEF1f8s46p+mG96As?=
 =?us-ascii?Q?aI8lNm1K6DvmaLqQuiFXqEJW5+WubzAllFQk3PeE/kCabfrg1TBhkeYR2cT1?=
 =?us-ascii?Q?1UXNwJQdcO7UG4EDVSCkaKKeL4t+FvwmlhYaK/VNwrqSVfFxMrkxdW8qyk6O?=
 =?us-ascii?Q?3mm99eRwF0a06aXBrDr6ROkOypevy0WHVBaVJrGWxykoXC/ntSs7ATkS8Tnq?=
 =?us-ascii?Q?MOKl7K3y0tgayS8VmzTqJWE3GiFnCy2VXBjGotzueNdZvqsoJdiybfcY3PFd?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <148CEF86B56BD247BD75D91B2999CC6F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a729898e-e402-41dd-4422-08dabb654935
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 17:28:12.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+6drHmefDhaQ4xLA5VxjCFe60y6a3EZ1TXejfrqBv6dEuu0SwY0tUyIszI8r5iOz6i6zEb3g+D6xsbSAizUwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310108
X-Proofpoint-ORIG-GUID: lqHqBEr8JMeZvO4gTZ2LsmJTtLadKxR4
X-Proofpoint-GUID: lqHqBEr8JMeZvO4gTZ2LsmJTtLadKxR4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2022, at 12:43 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-10-28 at 10:47 -0400, Chuck Lever wrote:
>> Remove the call to find_file_locked() in insert_nfs4_file(). Tracing
>> shows that over 99% of these calls return NULL. Thus it is not worth
>> the expense of the extra bucket list traversal. insert_file() already
>> deals correctly with the case where the item is already in the hash
>> bucket.
>>=20
>> Since nfsd4_file_hash_insert() is now just a wrapper around
>> insert_file(), move the meat of insert_file() into
>> nfsd4_file_hash_insert() and get rid of it.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Reviewed-by: NeilBrown <neilb@suse.de>
>> ---
>> fs/nfsd/nfs4state.c |   64 ++++++++++++++++++++++-----------------------=
------
>> 1 file changed, 28 insertions(+), 36 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 504455cb80e9..b1988a46fb9b 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4683,24 +4683,42 @@ find_file_locked(const struct svc_fh *fh, unsign=
ed int hashval)
>> 	return NULL;
>> }
>>=20
>> -static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc_=
fh *fh,
>> -				     unsigned int hashval)
>> +static struct nfs4_file * find_file(struct svc_fh *fh)
>> {
>> 	struct nfs4_file *fp;
>> +	unsigned int hashval =3D file_hashval(fh);
>> +
>> +	rcu_read_lock();
>> +	fp =3D find_file_locked(fh, hashval);
>> +	rcu_read_unlock();
>> +	return fp;
>> +}
>> +
>> +/*
>> + * On hash insertion, identify entries with the same inode but
>> + * distinct filehandles. They will all be in the same hash bucket
>> + * because nfs4_file's are hashed by the address in the fi_inode
>> + * field.
>> + */
>> +static noinline_for_stack struct nfs4_file *
>> +nfsd4_file_hash_insert(struct nfs4_file *new, const struct svc_fh *fhp)
>> +{
>> +	unsigned int hashval =3D file_hashval(fhp);
>> 	struct nfs4_file *ret =3D NULL;
>> 	bool alias_found =3D false;
>> +	struct nfs4_file *fi;
>>=20
>> 	spin_lock(&state_lock);
>> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
>> +	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
>> 				 lockdep_is_held(&state_lock)) {
>> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
>> -			if (refcount_inc_not_zero(&fp->fi_ref))
>> -				ret =3D fp;
>> -		} else if (d_inode(fh->fh_dentry) =3D=3D fp->fi_inode)
>> -			fp->fi_aliased =3D alias_found =3D true;
>> +		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
>> +			if (refcount_inc_not_zero(&fi->fi_ref))
>> +				ret =3D fi;
>> +		} else if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode)
>> +			fi->fi_aliased =3D alias_found =3D true;
>=20
> Would it not be better to do the inode comparison first? That's just a
> pointer check vs. a full memcmp. That would allow you to quickly rule
> out any entries that match different inodes but that are on the same
> hash chain.

Marginally better: The usual case after the rhltable changes are
applied is that the returned list contains only entries that match
d_inode(fhp->fh_dentry), and usually that list has just one entry
in it that matches the FH.

Since 11/14 is billed as a clean-up, I'd prefer to put that kind
of optimization in a separate patch that can be mechanically
reverted if need be. I'll post something that goes on top of this
series.


>> 	}
>> 	if (likely(ret =3D=3D NULL)) {
>> -		nfsd4_file_init(fh, new);
>> +		nfsd4_file_init(fhp, new);
>> 		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
>> 		new->fi_aliased =3D alias_found;
>> 		ret =3D new;
>> @@ -4709,32 +4727,6 @@ static struct nfs4_file *insert_file(struct nfs4_=
file *new, struct svc_fh *fh,
>> 	return ret;
>> }
>>=20
>> -static struct nfs4_file * find_file(struct svc_fh *fh)
>> -{
>> -	struct nfs4_file *fp;
>> -	unsigned int hashval =3D file_hashval(fh);
>> -
>> -	rcu_read_lock();
>> -	fp =3D find_file_locked(fh, hashval);
>> -	rcu_read_unlock();
>> -	return fp;
>> -}
>> -
>> -static struct nfs4_file *
>> -find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
>> -{
>> -	struct nfs4_file *fp;
>> -	unsigned int hashval =3D file_hashval(fh);
>> -
>> -	rcu_read_lock();
>> -	fp =3D find_file_locked(fh, hashval);
>> -	rcu_read_unlock();
>> -	if (fp)
>> -		return fp;
>> -
>> -	return insert_file(new, fh, hashval);
>> -}
>> -
>> static noinline_for_stack void nfsd4_file_hash_remove(struct nfs4_file *=
fi)
>> {
>> 	hlist_del_rcu(&fi->fi_hash);
>> @@ -5625,7 +5617,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct=
 svc_fh *current_fh, struct nf
>> 	 * and check for delegations in the process of being recalled.
>> 	 * If not found, create the nfs4_file struct
>> 	 */
>> -	fp =3D find_or_add_file(open->op_file, current_fh);
>> +	fp =3D nfsd4_file_hash_insert(open->op_file, current_fh);
>> 	if (fp !=3D open->op_file) {
>> 		status =3D nfs4_check_deleg(cl, open, &dp);
>> 		if (status)
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



