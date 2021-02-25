Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F86325270
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 16:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBYP3J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Feb 2021 10:29:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46994 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhBYP3C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Feb 2021 10:29:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PFPcaO050823;
        Thu, 25 Feb 2021 15:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MZZqyDNjAb21raNgY//e1RDTv9eZbxLjk6szwQYT7zc=;
 b=HV9JvZRNcdbsGXCq88hvafL4BVGlYCq7o0AxTUY7CcBJablx3csBKIvroud3c2ANKRfE
 ZYjtQfFPjctGYypA2r+jDIeOFyvqiRYadA02rXXRPY23YdFkIQrbIC977l6LzbyuJP5A
 cyRqqKEEo9CLT7gMTHdfXmdpQuLLfdjBmhnt5kxDSXOpVhk7egvb4aMtoWt5r1zNnvdz
 0gGNWtkHt81jjUf5sHqSX5Lf3VxY910yHr3RFMiqsV8/u2itajMuG4WFVVn92JtXWBy7
 0e8Cx2Likjn5jG1k8a2b8MUwWkA8JKuy9gPq2cmoJ4Xi9RP13V0XEtv/ND19F4FEEBbO qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36tsur6uva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 15:28:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PFQrgc113260;
        Thu, 25 Feb 2021 15:28:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 36ucc1bukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 15:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH9f1AiJN4kiQ5mw1lHfTPsJH5vgVFaAdZJ480XTumR5hnoxDcReoSaAJLO2zIGeQFrgIAC/DuA53F6MQUoZ4ahuEuibfFeAsnl3p1bhVX1E1hsY5NrYCRAIw0RXYRr8Omj2CckWfY592MoN+Ng9R78XhdAaSv7hJYm/c3Ff/cL1+Y0JNAKhORjCfG2EpzgOxgmFG2WcsUlU1c2lfseyl2hqDDuHeFH+j6VRollkCvv+nInSGi+ZlxigF5+N5ssLkk5x62qGe1nklQrgGrRNZ6TJPyaauNiSPmO0JeB4D+poA6d1yMMTeIZ2e2Gpmp5ToTjeUb1W138t45ufizP2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZZqyDNjAb21raNgY//e1RDTv9eZbxLjk6szwQYT7zc=;
 b=aFdLWHhRtqpJRKLJ2wUd2taAN5nYzhZE1W5Fk2bEtNBMQhfS+JYi9OMx5NvZT1jswb5P+rBuIf6rMUDwAVUVHo2L66X59UadXBbRFzWTaSHGQxtGLliltkX0H5UVYXxknPQGb9/jrnJpGTrlKjeQvs/nmRlj/VGpOz/rNbeL8mGfw7+KaLGbU1aFAMNDaq4T+QVd1aJW3/6OhoC3ASn7ruilKQHqwzl/SAYMmZtbJXjSw6Z0YIchV8qqKw5KvO/zbtWigvmgt+D4kKNpYPQ4UGzrkfMdn4uAn8IMMVr4GHe0QtEZehf08ZzQeq+9SDMv6OH30OSwDxOnQqcYXs+QOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZZqyDNjAb21raNgY//e1RDTv9eZbxLjk6szwQYT7zc=;
 b=wtRA7fMykR9e3Ymjg3fl0BqJ/L9LKxGUQSUh2vb1b5CO/bBrvFvzJX9eECqxpEnG+KTwg2Lcr07TPn2eLQkFkN0S2D7f0HoVch1cDi+3XlcnyxZWq/a37INjWeuamNMVgVbXmsVOFuM5bUi47wMvt+s+vG+wo5dekrvwpdXg2/k=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 15:28:08 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 15:28:08 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH] nfsd: don't abort copies early
Thread-Topic: [PATCH] nfsd: don't abort copies early
Thread-Index: AQHXCtx0cs5d9peX+k+/c+JLDyWeq6pnsZqAgAAAt4CAADIzgIABG2YA
Date:   Thu, 25 Feb 2021 15:28:08 +0000
Message-ID: <CDFF4F84-1A0C-4E4C-A18B-AC39F715E6D8@oracle.com>
References: <20210224183950.GB11591@fieldses.org>
 <20210224193135.GC11591@fieldses.org>
 <59A5F476-EE0C-454F-8365-3F16505D9D45@oracle.com>
 <20210224223349.GB25689@fieldses.org>
In-Reply-To: <20210224223349.GB25689@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f64afd4d-3ffa-4467-f45e-08d8d9a1f492
x-ms-traffictypediagnostic: BYAPR10MB2869:
x-microsoft-antispam-prvs: <BYAPR10MB2869EAD96CA796E4AE36D6D4939E9@BYAPR10MB2869.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SsAiHZFCZO0NRQPFfckpcQDyzeyZ/xQLuBmMCkHMADTVIDoU0lYo5l1UIvlBHCzK/5dzhRC0tCXEWeFfyM+IrshBqOlBo/rWgLf5C9UcQN1WGxZd3UNe7SIseifgAX/Ay1SRqiRXElFebMkTM6FDBIMUefCVpNt2yd7fQJqEZPzEMpYY0tdTsAJG3oAieCmeoTgpwWPIIFOOVOBRtJDrVhQarVWgPFsUGjIsp0gPdxRjMEiSSu+zhsMXWOZ5pcsToqW5yNNnKR9KW7nc49zwiPKxdRPENSo6jTofxaf2zJdOgcaVZpqThaje4dHw/VRJ9WvmAD6214f8pVzDmMq30n8Z5Yg9KAIPj8SkHys90vStyXLw0o36v2xS+vi26FJ9eX0CSpC0paox3nQ6QUzjzbBRmNFOr0dDvJUPpbfctJQ/mUW6d7lbvGhc1d26BydyPDhT1dFb5nj1QkeWbdUqMx3+n3H7YidphA6oXIj6hIZx0ap8bExKCj3phVKl0G18a/3iXQbFNNv9GcQsiwzQF3HP8xibwmScJQmWHblGFNLlSngVYp6kdsz7NVnGw7k9NLeDXtBrRI845lvjLna+ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(26005)(36756003)(2906002)(8676002)(66446008)(66556008)(66476007)(6512007)(66946007)(6916009)(186003)(2616005)(4326008)(76116006)(91956017)(86362001)(64756008)(33656002)(5660300002)(6506007)(6486002)(44832011)(71200400001)(53546011)(8936002)(478600001)(54906003)(316002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tGPZlewZ6W4avHM2xz/9q+vDIlqm2VDLAc48SfgRHqsNDLwuOIMKU3F6gjqu?=
 =?us-ascii?Q?R0lzXpLiqhKArq8hJ08/zQBPVl4Kd02NLG9zpqSaHSM0jAtyRTxwOEt5otsE?=
 =?us-ascii?Q?Ow0h6UjUTpiAdmvML8LRb+BIDRcrba8rIAirWOiiGrbClZkT2uT910//yujQ?=
 =?us-ascii?Q?zNuZhykMFKPW+BRK7pQFhfV7DV3bBzNcjH4mXwcaX13VXODUL2J/y7invvRr?=
 =?us-ascii?Q?KkC4sI0w4UQxQQK0067eiud5mkO/53cAc201aLYjF6anjkYSOHocFsGAHumR?=
 =?us-ascii?Q?QoRo6bOC7d0CK/tI8o9T28yQbqmvuEB2Cj1U+v5GaoJ3XnF0YYsL+4V5ECzu?=
 =?us-ascii?Q?kYAweZile1/xq92kQ7ikqH0aXx+bqUUNHvjlczvK00eo/xVXGc+V4uYuMvow?=
 =?us-ascii?Q?g+J/fAw68Q+IlFTlVqAxJohhATRdTPv042YFyXM91lCUxWpoyCjTkIraAILq?=
 =?us-ascii?Q?77m7PRCkQ4qkZUrPXJWKxGzwfb7YqByXQT6itId+EkQjb0MUmTI24WxIy5iP?=
 =?us-ascii?Q?rg/9pRC8fwBVJmto8cluoaAcFdZ+45R3uWLJ3rveGHRPYPfBnlJ0gnEBOowL?=
 =?us-ascii?Q?EZ+Yed3i5NZiFHIIrMq+tow+XB2lyhcieqYi25GzWtti0mDhiz9BDc+vv56z?=
 =?us-ascii?Q?FhWYK69GmvVZIKLSuT/LeCUBcz2WXNyMPjMW1U+FnrYgsyvJmxmsnv318b+p?=
 =?us-ascii?Q?SFDbvVg2echimxUyBMZAAsMcf32W8W55pXvdfHbvef3kgGDfanSUgcpHof+w?=
 =?us-ascii?Q?NEj1fGXfrCydUpvMyacQZKUTO6WvrAXeprQa0AV0JRs6xXn/lT1yRiOs6ZtZ?=
 =?us-ascii?Q?QXP3D7EcvLyYbml9e8IYEeebezVPpdlQf5xWuw1HmUgZ1ibFWVwcnmKKoOC+?=
 =?us-ascii?Q?lYnswsu4j4cDn7UNXhmjz+obFkHPdclBfezWAXCkZ3k/UGmEz2dlORBek8eI?=
 =?us-ascii?Q?mdyZmOgZTLLyNJLUPq2dNSUI9XZHvzPSfezpct7Bx9VFDH81FFtNyH4uuZ7b?=
 =?us-ascii?Q?vDWalojKehWyLKuziDJdVTJhHnaNWo7vSXyu5skQOv7xGilQ+phpFS7xfZI+?=
 =?us-ascii?Q?6Fb12NzGGSBek+QQkKG7Tl0ZRtTatjwBiJi6Sq9VRcqvAVf+89YbbAQfjRQZ?=
 =?us-ascii?Q?UECh601vAmjAAA2mwHPLJKiWizYSZEqWmcNoY+d+K6Rz9/4vev7OCwu/ADmh?=
 =?us-ascii?Q?ytUOAV09JBXAYT/1xiCmE5Pt0aUZBJCLt5MW/6xxUxeuq6U4hVpovwooo8y8?=
 =?us-ascii?Q?xJxEbWuaAl8ORR/AOREk2OwQKhZItBMUfpS8/3YUKT5r5VlBpWFznjCcunEb?=
 =?us-ascii?Q?ZZm/+2cK0sRzzwFxNebO17R1L9dNNJp7YGPnj9Nvegp5Ag=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39A202F8AEC715439EE24BB9BB223037@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64afd4d-3ffa-4467-f45e-08d8d9a1f492
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 15:28:08.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rfs5qjyViDsASkrldYuVp8T+yIDFLbht2JIi779CjlaRZnDUM2eoCnhaZWiQIt4ZoppWDKd3CImEKr/R85yEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2869
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250125
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 24, 2021, at 5:33 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Wed, Feb 24, 2021 at 07:34:10PM +0000, Chuck Lever wrote:
>>=20
>>=20
>>> On Feb 24, 2021, at 2:31 PM, J. Bruce Fields <bfields@fieldses.org> wro=
te:
>>>=20
>>> I confess I always have to stare at these comparisons for a minute to
>>> figure out which way they should go.  And the logic in each of these
>>> loops is a little repetitive.
>>>=20
>>> Would it be worth creating a little state_expired() helper to work out
>>> the comparison and the new timeout?
>>=20
>> That's better, but aren't there already operators on time64_t data objec=
ts
>> that can be used for this?
>=20
> No idea.

I was thinking of jiffies, I guess. time_before() and time_after().

Checking the definition of time64_t, from include/linux/time64.h:

typedef __s64 time64_t;

Signed, hrm. And no comparison helpers.

I might be a little concerned about wrapping time values. But any
concerns can be addressed in the new common helper state_expired(),
possibly as a subsequent patch.

If you feel it's ready, can you send me the below clean-up as an
official patch with description and SoB?


> --b.
>=20
>>=20
>>=20
>>> --b.
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 61552e89bd89..00fb3603c29e 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5363,6 +5363,22 @@ static bool clients_still_reclaiming(struct nfsd=
_net *nn)
>>> 	return true;
>>> }
>>>=20
>>> +struct laundry_time {
>>> +	time64_t cutoff;
>>> +	time64_t new_timeo;
>>> +};
>>> +
>>> +bool state_expired(struct laundry_time *lt, time64_t last_refresh)
>>> +{
>>> +	time64_t time_remaining;
>>> +
>>> +	if (last_refresh > lt->cutoff)
>>> +		return true;
>>> +	time_remaining =3D lt->cutoff - last_refresh;
>>> +	lt->new_timeo =3D min(lt->new_timeo, time_remaining);
>>> +	return false;
>>> +}
>>> +
>>> static time64_t
>>> nfs4_laundromat(struct nfsd_net *nn)
>>> {
>>> @@ -5372,14 +5388,16 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 	struct nfs4_ol_stateid *stp;
>>> 	struct nfsd4_blocked_lock *nbl;
>>> 	struct list_head *pos, *next, reaplist;
>>> -	time64_t cutoff =3D ktime_get_boottime_seconds() - nn->nfsd4_lease;
>>> -	time64_t t, new_timeo =3D nn->nfsd4_lease;
>>> +	struct laundry_time lt =3D {
>>> +		.cutoff =3D ktime_get_boottime_seconds() - nn->nfsd4_lease,
>>> +		.new_timeo =3D nn->nfsd4_lease
>>> +	};
>>> 	struct nfs4_cpntf_state *cps;
>>> 	copy_stateid_t *cps_t;
>>> 	int i;
>>>=20
>>> 	if (clients_still_reclaiming(nn)) {
>>> -		new_timeo =3D 0;
>>> +		lt.new_timeo =3D 0;
>>> 		goto out;
>>> 	}
>>> 	nfsd4_end_grace(nn);
>>> @@ -5389,7 +5407,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
>>> 		cps =3D container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
>>> 		if (cps->cp_stateid.sc_type =3D=3D NFS4_COPYNOTIFY_STID &&
>>> -				cps->cpntf_time < cutoff)
>>> +				state_expired(&lt, cps->cpntf_time))
>>> 			_free_cpntf_state_locked(nn, cps);
>>> 	}
>>> 	spin_unlock(&nn->s2s_cp_lock);
>>> @@ -5397,11 +5415,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 	spin_lock(&nn->client_lock);
>>> 	list_for_each_safe(pos, next, &nn->client_lru) {
>>> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
>>> -		if (clp->cl_time > cutoff) {
>>> -			t =3D clp->cl_time - cutoff;
>>> -			new_timeo =3D min(new_timeo, t);
>>> +		if (!state_expired(&lt, clp->cl_time))
>>> 			break;
>>> -		}
>>> 		if (mark_client_expired_locked(clp)) {
>>> 			trace_nfsd_clid_expired(&clp->cl_clientid);
>>> 			continue;
>>> @@ -5418,11 +5433,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 	spin_lock(&state_lock);
>>> 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>>> 		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>>> -		if (dp->dl_time > cutoff) {
>>> -			t =3D dp->dl_time - cutoff;
>>> -			new_timeo =3D min(new_timeo, t);
>>> +		if (!state_expired(&lt, clp->cl_time))
>>> 			break;
>>> -		}
>>> 		WARN_ON(!unhash_delegation_locked(dp));
>>> 		list_add(&dp->dl_recall_lru, &reaplist);
>>> 	}
>>> @@ -5438,11 +5450,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 	while (!list_empty(&nn->close_lru)) {
>>> 		oo =3D list_first_entry(&nn->close_lru, struct nfs4_openowner,
>>> 					oo_close_lru);
>>> -		if (oo->oo_time > cutoff) {
>>> -			t =3D oo->oo_time - cutoff;
>>> -			new_timeo =3D min(new_timeo, t);
>>> +		if (!state_expired(&lt, oo->oo_time))
>>> 			break;
>>> -		}
>>> 		list_del_init(&oo->oo_close_lru);
>>> 		stp =3D oo->oo_last_closed_stid;
>>> 		oo->oo_last_closed_stid =3D NULL;
>>> @@ -5468,11 +5477,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 	while (!list_empty(&nn->blocked_locks_lru)) {
>>> 		nbl =3D list_first_entry(&nn->blocked_locks_lru,
>>> 					struct nfsd4_blocked_lock, nbl_lru);
>>> -		if (nbl->nbl_time > cutoff) {
>>> -			t =3D nbl->nbl_time - cutoff;
>>> -			new_timeo =3D min(new_timeo, t);
>>> +		if (!state_expired(&lt, oo->oo_time))
>>> 			break;
>>> -		}
>>> 		list_move(&nbl->nbl_lru, &reaplist);
>>> 		list_del_init(&nbl->nbl_list);
>>> 	}
>>> @@ -5485,8 +5491,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>>> 		free_blocked_lock(nbl);
>>> 	}
>>> out:
>>> -	new_timeo =3D max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>> -	return new_timeo;
>>> +	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
>>> }
>>>=20
>>> static struct workqueue_struct *laundry_wq;
>>=20
>> --
>> Chuck Lever
>>=20
>>=20

--
Chuck Lever



