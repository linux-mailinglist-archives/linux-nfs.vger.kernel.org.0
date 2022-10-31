Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83583613C5D
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 18:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiJaRmD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiJaRlv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 13:41:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F7513D38
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 10:41:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGx9OV026924;
        Mon, 31 Oct 2022 17:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uxY6jxuSqcoPhT9ZK32VWiw2ms7f0jYOrKW+4JZWob4=;
 b=F/ciLfmg7o8spbhGOzE3Yc4dhLaAOT/37kccn/DzYGgyemKhCZ6wSYqLjAvdvIIuzeDj
 57vtBm6G2iElwfSmMRwuwqTD/frjkFuz9ongX62KXjTW7ExF9ZZvWwjxFNwSj1ajFK/s
 qOTDMD98APKKIgQJJpPVwNKBKkiQ/PtzwG8EkmADdX048Bl1v+DOkZybJ7ZgfSWrAsag
 eBxXMxhNBIXxUJvsk7jbCSdX08MYDtvB6OEsczwCDyoQTT/WhXZYDmYEu72e8hsVxuHW
 9Eznz2P2M8hpS+y/HaxY0iSD+dJkyMqtewkRLWEnyYAIdG9SOuK4ui38IPhy4IT712iO Ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts14fed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 17:41:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTkhA033168;
        Mon, 31 Oct 2022 17:41:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3jd17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 17:41:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcGfNaRB4Mz2Eom65WpIEZUVKHDq0SvY343cFqGRyG5QJAzCZvjkhHNw7LVKdxfetUeOLKmDjhVAsRzoLjOSZYJ1UbGwsc5RoQ//3aDVvDcxqZe60vFumWgPz7Hh0//jWDPL6qIGDb62JJe1HB6kBL7oBxKnFAiMj6ISmVN5JKQWXyot4qVgKstpCqG+anK3GjV5EMo3/o8Izs6vYExBKlGmsbja1PvIszN9SWE63kYfUS+XS/J8AHe4n/ceB5l9JG2sJcXQoI5iebO1i+8FEJK5DBQjZv/OLlCFUGef3CVv804QfI/nyYf1qUI4jFI3pSbIOzjRgVOIlZLk0x9/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxY6jxuSqcoPhT9ZK32VWiw2ms7f0jYOrKW+4JZWob4=;
 b=NyKa9++id6WNcff/8CucSyB5EgM6NNkL5WKARQ+X48bhQFyibfN5YjMskSUboI4edhUBfMxzEie61Tqx+Zt10z+M1hEio8IGYQifldcg0HlzLfFj6+8AHwg9j+ZboFnWBmGVHaAKR8wM9IGa2oyDqvZ0Pt6Nwz3zlxWofIyD3zXBaCTAnrDQ2UVs6rA5MHtzfR0haiEf8j1e5rJ05ZbG09NngRbh5p7JEqzczMmqdPSLyLfrZl/yZIZfFNNvKlTMNgrygd2ta/U/Id4uJGnamenyKTstevUmVaL7iyEO8BQ6+KieF6/T1sa8SJsxlDCmkLfesQyXK+jY1Kt0mM3p5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxY6jxuSqcoPhT9ZK32VWiw2ms7f0jYOrKW+4JZWob4=;
 b=ZMWSLw+LzHUld7ilvAgq7SE5uSplpEpEvjVr5FQ2yhm83aLU90jonnaFLp28UwZ1Jj8f+XHYEwDijxkeoRejyzXT50cw99zLxvrpkHRqN4md/oiN98U0HDuOrTpnhIf39cQa0IcykGppQsMiAyhSBiOToFIVauUJiWI1+DzrAeY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6555.namprd10.prod.outlook.com (2603:10b6:510:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 31 Oct
 2022 17:41:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 17:41:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v7 11/14] NFSD: Clean up find_or_add_file()
Thread-Topic: [PATCH v7 11/14] NFSD: Clean up find_or_add_file()
Thread-Index: AQHY6tx623edtfKYkU2VQ0hX3WF+qK4ouhwAgAAMd4CAAAJbgIAAAWiA
Date:   Mon, 31 Oct 2022 17:41:39 +0000
Message-ID: <0D9A0B36-6C76-4A58-8F5C-2BCD41D1EF97@oracle.com>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
 <166696846122.106044.14636201700548704756.stgit@klimt.1015granger.net>
 <d9bd2d0f17c53ce864e093324ad6ccc9de1871c5.camel@kernel.org>
 <D051BD59-3962-4A0D-B099-F50F50616BAD@oracle.com>
 <fa08f6f6f33a9a18d85af63373f4d1381e3a1872.camel@kernel.org>
In-Reply-To: <fa08f6f6f33a9a18d85af63373f4d1381e3a1872.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6555:EE_
x-ms-office365-filtering-correlation-id: f021d389-bf8a-41bb-7495-08dabb672aa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2AfJCo0J70SJwi1KbUZrg0yuV44G3tlnZxD2yc2+JMDtkdbKSCT//89mtITNg/52Tms9uHltm3D2PknkTwOOXrwMPMMiDyymE+JNjF0lY3BCtxgO5T2SZoi+n/5SAXU5+IefPFMHGgJzPJ+zjHtV3ocfIfQs6TGuEB07uaZSRuc5ZbHzhdl9aMWV9B7suzMEd7V5yXqcw+2WNU7/ajOXRmmyNalQKNt44LaB5x4X7NMzIPz3KuzbW6uWpqhER62YUDidoF3e94OLDQcnK61FA85LDkfIK9O+yOW7G4WQVwR3lVKsv+lrKocgjzzs70B98FqFmcMTlqoAS2gBwuJQP3/M8K1ejtmIGW+58U73l+4Jp1XU2jU1aw3DJiHCnHwQyFNIRnx9t/wNtACWl96rV8uJ7+o5dE7UamtAXR5CnvFLsPYS7ZN80uXGHP2JOKPlLBqRCr8IieCk4lBzH/d6a6Q0A3W15aLfXTXW1IMGjQVx9hhbPu8oYQa8Xomougs5Rgpcb0aj7Gl15l6/xhb0iZ6M+qfxAOuJZrjJ1vI4YRbvjUFwAr5r7K/xggyn/MIs7uZ/Ikwl74mI5Rxd5nSDv311Itxpnp/lukiQyzBbOytpdswJY/wqsRMeAyK74gfN0eh/BX9v4uob12DfH1ue/IeWjIrB7vn0Ek+6vGOdyK/DVh031ox68CrcPlcl8Rmuby6hTZIL1VeOByko4BvrqV8YwySXoFKKFS/cyWZPcf4wIbVfk3hw5USz3m0MaiBXemWLahuZiKibkEr/LMiMwEydQxhZ9WQNjQkJMcqHuWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(26005)(186003)(71200400001)(6512007)(4001150100001)(83380400001)(2906002)(478600001)(2616005)(54906003)(66446008)(4326008)(5660300002)(66946007)(64756008)(8676002)(76116006)(6916009)(41300700001)(66476007)(91956017)(6506007)(8936002)(66556008)(6486002)(316002)(66899015)(33656002)(38070700005)(53546011)(36756003)(86362001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VVCL0LCWqcAG0djH1zjzAduTMkLlZJT9xFXab+s1scDw57xMMRACW1dbpaZg?=
 =?us-ascii?Q?jBBQSkf55alQ2x5C8FlCFp1dHdY3B4AZaJdU00rZXxQ/nIfZ+iHr6ArhOCzR?=
 =?us-ascii?Q?yr75N20pbxId+9sTkmsc6cu/DXYEJWRgPazTpyOX9l1dz62Ceiim7OcnWo28?=
 =?us-ascii?Q?gc+aY0kwD7wvFkGmPbhrunPVkfVwMtQ6DC/Ghz6G6rgO3mZJiLqDrrUzfeHd?=
 =?us-ascii?Q?5TnERrnznaaGAZzVd2SxPNf3pbcR4gW9ojSs/Ul3CCDGc6mCvxjYmXBvBOME?=
 =?us-ascii?Q?hBSfWsznnFPzJSI+CApZiJbawjsMtENO9ctq4ToIKyLu75WQFSfD4Y66nWEf?=
 =?us-ascii?Q?0v1IPBhvrfX8KW+iZhxR6g4Tr8DHHQ7AG9YKv/BTyf+8phSmzQ+RVORTpukL?=
 =?us-ascii?Q?3+i072gowZKFoQpvJae/5WOUVpYGVX/Wzi4a43jb/mZPEDYhpfpI/RAiVXBx?=
 =?us-ascii?Q?QF2F+FJb8xpiSsg0pECRjTEncS7OmlLxeVCMnFqCj8D67h5rZA4p4+Y2SNvt?=
 =?us-ascii?Q?S3Oxttb+mic8cQdpqftSWpc2977caqJ7LoPaRygKcT76phfsdslet3k1kVl7?=
 =?us-ascii?Q?IsUPgtAk3yzHk58njEPW9yIOviVHCPfClOtb2rTSUOl+5YJMl7ynkVV27AJ2?=
 =?us-ascii?Q?eVN2f/WJX/V9mu0CEj8FE7AyanY4KiDgln7FiGBMAATVP8u+I4/2Vu066kAO?=
 =?us-ascii?Q?3TMXOUHnZ+WVUN0yZ4xv67xmc9NWj/b2ZiAKsLP8sJa29nG9tpftTfgJMuUb?=
 =?us-ascii?Q?Qw88yqviOp7X/VbNzWfBIXRFfKQjIUGd/GB0Rc/jJdCD+8pBXav5zeA4bbmD?=
 =?us-ascii?Q?TFxzaIhKugvwoCVTC94zZ1f9Ii7dH2S0u1h/6NAd5P9pJ1FJ5UuFGZpfrUzu?=
 =?us-ascii?Q?vpACluxE/hp0+3tZIpl0ijo8gGTRLp3CUJh/6mRqxZi8/0ucigLNtQkcmGSJ?=
 =?us-ascii?Q?QjLiOYPXXoHHN3wGjFeaaaxRHAep8ms8INJLd8TjBIO2GPPmPjLPTcVz3ATG?=
 =?us-ascii?Q?sj+rcwmtvkxVMZofZp3shRjk4JOF6kfMFmJK+HwwqogjVyyIIgET3V222MeI?=
 =?us-ascii?Q?RiTNLiFtlRc5H8JNPq786FWe4fdrj+lIknKFeo3YIkORRFS0i0psEH+YDxd6?=
 =?us-ascii?Q?GMNBteLOj3Vv/L80KofcmfjKcIpJ05YKrj1eQ1pLQrCZGX8SYy+F34sf7UvC?=
 =?us-ascii?Q?1x09d67tSKV0Uu8USr6fdWuCv1N3RRcefNkj7qC/7DqBN2qJzwFa/YdsDjz6?=
 =?us-ascii?Q?YGABviOmINWKpvLvDqEDLCaFLfNwaXvLFQLGHOVSgnnk+QR3dvhppXD5gkjb?=
 =?us-ascii?Q?z0AQ0GFexqFhkz+FwDTiSoS+kYlrNBinhHCDPcFGrJ7WtjHnvK4P6fvAX5w4?=
 =?us-ascii?Q?V6GOeVYmKiJl1GT0sXIcTT2SujnBT11qWF1riX46HpnPiS30qdAdEjofDOnX?=
 =?us-ascii?Q?qlOXi2uvBwUpeyc2uShmizQ3f3qUbm/GPDtqbaLg/AToXI4Q8+GzBxc5DtJJ?=
 =?us-ascii?Q?EOPQC9zw2wfDwxVAK7uO9JHXn2NRRz+F7Crtt18XaVbSVLOhMmG+tAxnSMna?=
 =?us-ascii?Q?8Fn18eEc8cxPZGmK9KZDzoUWtDgCld5krv0wx6w5TUtYfEA8g06Qs9PQ4msC?=
 =?us-ascii?Q?cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B5BD57C737C2C45A6F487A264DAB9BF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f021d389-bf8a-41bb-7495-08dabb672aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 17:41:39.7258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwLIzzQNZSFSp6xiXeX0NagTPquJvVTJDaalAQmU+/24pZueyF84uIma3VYFoYJ41rWj4yNBPtvAX8DEC0HL1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310110
X-Proofpoint-GUID: Vo7yYHdj08CbjmGn65JcwTXXBh9ANFXg
X-Proofpoint-ORIG-GUID: Vo7yYHdj08CbjmGn65JcwTXXBh9ANFXg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2022, at 1:36 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-10-31 at 17:28 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 31, 2022, at 12:43 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Fri, 2022-10-28 at 10:47 -0400, Chuck Lever wrote:
>>>> Remove the call to find_file_locked() in insert_nfs4_file(). Tracing
>>>> shows that over 99% of these calls return NULL. Thus it is not worth
>>>> the expense of the extra bucket list traversal. insert_file() already
>>>> deals correctly with the case where the item is already in the hash
>>>> bucket.
>>>>=20
>>>> Since nfsd4_file_hash_insert() is now just a wrapper around
>>>> insert_file(), move the meat of insert_file() into
>>>> nfsd4_file_hash_insert() and get rid of it.
>>>>=20
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Reviewed-by: NeilBrown <neilb@suse.de>
>>>> ---
>>>> fs/nfsd/nfs4state.c |   64 ++++++++++++++++++++++---------------------=
--------
>>>> 1 file changed, 28 insertions(+), 36 deletions(-)
>>>>=20
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 504455cb80e9..b1988a46fb9b 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -4683,24 +4683,42 @@ find_file_locked(const struct svc_fh *fh, unsi=
gned int hashval)
>>>> 	return NULL;
>>>> }
>>>>=20
>>>> -static struct nfs4_file *insert_file(struct nfs4_file *new, struct sv=
c_fh *fh,
>>>> -				     unsigned int hashval)
>>>> +static struct nfs4_file * find_file(struct svc_fh *fh)
>>>> {
>>>> 	struct nfs4_file *fp;
>>>> +	unsigned int hashval =3D file_hashval(fh);
>>>> +
>>>> +	rcu_read_lock();
>>>> +	fp =3D find_file_locked(fh, hashval);
>>>> +	rcu_read_unlock();
>>>> +	return fp;
>>>> +}
>>>> +
>>>> +/*
>>>> + * On hash insertion, identify entries with the same inode but
>>>> + * distinct filehandles. They will all be in the same hash bucket
>>>> + * because nfs4_file's are hashed by the address in the fi_inode
>>>> + * field.
>>>> + */
>>>> +static noinline_for_stack struct nfs4_file *
>>>> +nfsd4_file_hash_insert(struct nfs4_file *new, const struct svc_fh *fh=
p)
>>>> +{
>>>> +	unsigned int hashval =3D file_hashval(fhp);
>>>> 	struct nfs4_file *ret =3D NULL;
>>>> 	bool alias_found =3D false;
>>>> +	struct nfs4_file *fi;
>>>>=20
>>>> 	spin_lock(&state_lock);
>>>> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
>>>> +	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
>>>> 				 lockdep_is_held(&state_lock)) {
>>>> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
>>>> -			if (refcount_inc_not_zero(&fp->fi_ref))
>>>> -				ret =3D fp;
>>>> -		} else if (d_inode(fh->fh_dentry) =3D=3D fp->fi_inode)
>>>> -			fp->fi_aliased =3D alias_found =3D true;
>>>> +		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
>>>> +			if (refcount_inc_not_zero(&fi->fi_ref))
>>>> +				ret =3D fi;
>>>> +		} else if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode)
>>>> +			fi->fi_aliased =3D alias_found =3D true;
>>>=20
>>> Would it not be better to do the inode comparison first? That's just a
>>> pointer check vs. a full memcmp. That would allow you to quickly rule
>>> out any entries that match different inodes but that are on the same
>>> hash chain.
>>=20
>> Marginally better: The usual case after the rhltable changes are
>> applied is that the returned list contains only entries that match
>> d_inode(fhp->fh_dentry), and usually that list has just one entry
>> in it that matches the FH.
>>=20
>=20
> That depends entirely on workload. Given that you start with 512
> buckets, you'd need to be working with at least that many inodes
> concurrently to make that happen, but it could easily happen with a
> large enough working set.

I take it back. Neil pointed this out during a recent review: the
rhltable_lookup() will return a list that contains _only_ items that
match the inode. So that check is no longer needed at all. Patch
14/14 has this hunk:

+       list =3D rhltable_lookup(&nfs4_file_rhltable, &inode,
+                              nfs4_file_rhash_params);
+       rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
                if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
                        if (refcount_inc_not_zero(&fi->fi_ref))
                                ret =3D fi;
-               } else if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode)
+               } else
                        fi->fi_aliased =3D alias_found =3D true;
        }

which removes that check.


>> Since 11/14 is billed as a clean-up, I'd prefer to put that kind
>> of optimization in a separate patch that can be mechanically
>> reverted if need be. I'll post something that goes on top of this
>> series.
>>=20
>=20
> Fair enough. You can add my Reviewed-by: and we can address it later.
>=20
>>=20
>>>> 	}
>>>> 	if (likely(ret =3D=3D NULL)) {
>>>> -		nfsd4_file_init(fh, new);
>>>> +		nfsd4_file_init(fhp, new);
>>>> 		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
>>>> 		new->fi_aliased =3D alias_found;
>>>> 		ret =3D new;
>>>> @@ -4709,32 +4727,6 @@ static struct nfs4_file *insert_file(struct nfs=
4_file *new, struct svc_fh *fh,
>>>> 	return ret;
>>>> }
>>>>=20
>>>> -static struct nfs4_file * find_file(struct svc_fh *fh)
>>>> -{
>>>> -	struct nfs4_file *fp;
>>>> -	unsigned int hashval =3D file_hashval(fh);
>>>> -
>>>> -	rcu_read_lock();
>>>> -	fp =3D find_file_locked(fh, hashval);
>>>> -	rcu_read_unlock();
>>>> -	return fp;
>>>> -}
>>>> -
>>>> -static struct nfs4_file *
>>>> -find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
>>>> -{
>>>> -	struct nfs4_file *fp;
>>>> -	unsigned int hashval =3D file_hashval(fh);
>>>> -
>>>> -	rcu_read_lock();
>>>> -	fp =3D find_file_locked(fh, hashval);
>>>> -	rcu_read_unlock();
>>>> -	if (fp)
>>>> -		return fp;
>>>> -
>>>> -	return insert_file(new, fh, hashval);
>>>> -}
>>>> -
>>>> static noinline_for_stack void nfsd4_file_hash_remove(struct nfs4_file=
 *fi)
>>>> {
>>>> 	hlist_del_rcu(&fi->fi_hash);
>>>> @@ -5625,7 +5617,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, stru=
ct svc_fh *current_fh, struct nf
>>>> 	 * and check for delegations in the process of being recalled.
>>>> 	 * If not found, create the nfs4_file struct
>>>> 	 */
>>>> -	fp =3D find_or_add_file(open->op_file, current_fh);
>>>> +	fp =3D nfsd4_file_hash_insert(open->op_file, current_fh);
>>>> 	if (fp !=3D open->op_file) {
>>>> 		status =3D nfs4_check_deleg(cl, open, &dp);
>>>> 		if (status)
>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



