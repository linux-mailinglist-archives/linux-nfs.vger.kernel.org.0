Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA89321AA5
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 15:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBVO66 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 09:58:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45004 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhBVO64 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 09:58:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MEoXfO196251;
        Mon, 22 Feb 2021 14:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GFi7DohHpaGQYbjxPsDatlFxtfaakMo6IM11tLy528U=;
 b=RwKExHlKUn7TZZT2Fl5B9GQ/i0Me6cfTGvem0/2pVfKUTB3Bb8+g62oJia8YQ4ZCwoQC
 D50LZZ5D0WFZY3RsSCnXmf3nYrueLraW3mNAwt+cR5B2r1qA2VqFcu/iE7JArcTDS7VG
 hU5T4Lju3ONr8nQNV16N4+PsNTp3jJG3/rIovi47nk3XJu+LFK4/CXc7yGu3uxo92ASW
 RLAymcmaf+VVqbCVzAq0GOzHkRt/AjmXH/LxMFhzWGnfuvkJ45UoWb2o38aMNF9pYxMB
 LczJNyoh5uRqgFHmIitXdg1lWJQ+nUPajLYj+FktXA/tLMCL2TECMNKgHN3dUbvNIJiJ Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36ttcm3vhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 14:58:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MEu2uV177876;
        Mon, 22 Feb 2021 14:58:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 36uc6qes9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 14:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTawDPW5RfmjcTgYZA14aK6Jie78kvCZ6h0+8n3HjoCPeG5OTgTxSDcmBXmBOoxX5e8+tFyJUrA7hGKFt4sq2/6llqimLNSeuXMtv5XLIjugc5OQjFH9wZt3IQh+A7IC7VQjEDwNq6cecq4YcmjmbAIBH9ZyVf+aJNMlwpK8O96PxnH2gg4y3uuQz5W6TnLE8unKLXPagLSaytzKEf07yRYXPmvqzkxEMCheg0bxJMMlKY6Y/hnguCVk0Tv4YWXFMNBmmkjCwdB7C/+i3TbcxA+sCNbmWKjvEpIsB4cuAkLuqc37CFX2+856gWaWx0TbeCDwwdPSjuVK05yoyrktBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFi7DohHpaGQYbjxPsDatlFxtfaakMo6IM11tLy528U=;
 b=AnforFW/YJkXz1zXWw756hYfA7ELQK6iD7Ks9Cu4YnjwhD2/iFWScQsWGA2nkY1p3cZAcpU3DxTwJRP3kZR1p5tm5EDB3iE4IMazLNsoumCak4/zeQD5iknqbxyIwfPH1yn2Rav+b6p7YLy2UnllYs930pjpjk0vnVC+iNKLzBIQO/ynJtZs8McR+lV47GZoRUspiJBBa6/dHZy482BYLlJeq4V2M0nb8uBysR6EIqWlx1VQfZaqhJugfqLZ6dbb0hwz9jo8HytjGbpr9YX1oTvMfff88fdJM0iJM10aUsRW2ddhWu1a475iGzr+INhsOQKjZLrHvXe9v59WjGswNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFi7DohHpaGQYbjxPsDatlFxtfaakMo6IM11tLy528U=;
 b=SstMEZvhkDhj7hr0boZtkrEhuadcg9iyvf/uHZjHL1mu4SNRe1sC8wMkiLFeRwEId9E8R8QG9UDBey7jga5Gc0TaWAeGdMmd8i3/xRleYlvHMEgOvtJsJZmePZTkcJO6XGfNzMahW8aSuBYxFjrLXxXU4YHfVIDp42Ggg2Hgp+c=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3030.namprd10.prod.outlook.com (2603:10b6:a03:92::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 22 Feb
 2021 14:58:04 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 14:58:04 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH RFC] SUNRPC: Refresh rq_pages using a bulk page allocator
Thread-Topic: [PATCH RFC] SUNRPC: Refresh rq_pages using a bulk page allocator
Thread-Index: AQHXA7YYi2Q/13qtIEOp2oGf+6ELuqpj9JSAgABaPIA=
Date:   Mon, 22 Feb 2021 14:58:04 +0000
Message-ID: <33A16CEA-24CA-447A-AE8C-824771E9B3E1@oracle.com>
References: <161340498400.7780.962495219428962117.stgit@klimt.1015granger.net>
 <20210222093505.GG3697@techsingularity.net>
In-Reply-To: <20210222093505.GG3697@techsingularity.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3dd4fcd-1366-434c-bc6f-08d8d74241f4
x-ms-traffictypediagnostic: BYAPR10MB3030:
x-microsoft-antispam-prvs: <BYAPR10MB3030D403573BCB577387E17A93819@BYAPR10MB3030.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ujm631cYZFlbiIupZLpXXNHY9smWl/RJolOyTZzN08sKLfj5Z5rEhhesqKfL72HagSaLlmwzDaiCTRm0Y91aCFIOaQrlCOLaaM2PHRT7mJWr+yoObmJDTywvYhaI/biObdBIJokayKWdIxKcSIerPoEVIObuR1wMnKgLOKB4bipx2bp00SdCrMztVND3/s4U/d00rfKTwZLqzj54hLbrRxAjk2xVi1wY6bQEBnq4cuJnGjrE8r3q1b2JT+FT3I4I95VP+LQKzUpnb+BVUd8Z25cIDeoMehgsTEjQyBsifqZsUzarMdcGa//F/SX+AkE9o17d2tZN7uB9+3UV2LJwAU9bymo5qvrXGDNLQypc3G36hqNfg+1feGiF5UkatmmcFSk1CtESZrHlNf1+iNyRf8811tK0igHrzYWiIu+Rfo4eYRcywhYS3INks1TGWSst5dRaYpcNoUA9F67cDqCfS9J5mha594Z9wUvaSz0IN3AX1s9qtgq2+dz9O2DOh0bdUIyAe6omCEZ/S9V8G4fh7kNOmPGLQYfcx4BEXQjVap/dX2H24YoGtEDjD6a8+b0uBp84fFQq5lu56QNjvIlA4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(83380400001)(186003)(26005)(6916009)(66946007)(66446008)(5660300002)(478600001)(66476007)(64756008)(91956017)(4326008)(66556008)(8936002)(71200400001)(76116006)(6512007)(33656002)(44832011)(8676002)(86362001)(316002)(54906003)(6486002)(36756003)(2616005)(2906002)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QHRR79AU0NqiPCnalba/0y2jqcSOPWnAxuPcdo5kBYc7yhWkUClcjCnSotGZ?=
 =?us-ascii?Q?U1SrLEmuO0KtwsoIku33AWCtedm0rb9Q/9GkCM30vsqk5RNxk9Xsk+RUZ4M6?=
 =?us-ascii?Q?tuJ+kvo4dcwOm7Pyg5BAD+Aye6gw/t+InoueK+YMEj9aXsyI4KA9cA0EhuiW?=
 =?us-ascii?Q?zYD56Y4XhdEO2L9T0Kv6Wl+vkEzDItAhaHrKjtuuQD0SEwVPJeqEG3jk6VwN?=
 =?us-ascii?Q?81BbeUzXIbV5y3/dHD81hHWNVlYAKPIzOHNgPCHzSA5eujTty7Rg5f4wtfg7?=
 =?us-ascii?Q?tYBPkzb3pRjC0LjGKfyH9UKWg0kvYrqtLXxHZQfjMwW9lunYfTShDqU2QZY5?=
 =?us-ascii?Q?FrfnDD639Lu0RAmgRsWSymZvoREFUCY2GlJ2ZvPeAPLY5FqrqQLUxx3nPvhi?=
 =?us-ascii?Q?K+BMaagJ8lULhihhaAn12M5pmEIeWWXsAyUVnxJOc2MZKzrlFmndJPR3/iA0?=
 =?us-ascii?Q?m+qR2VvdQJVOhkaNQeD6jPr/5ugXfaDvb1Cd3wlepOmGUGmH/rI2PSzI1ojJ?=
 =?us-ascii?Q?f+LLJ3cNCb5HE0yOO/jioWZ1YpvMPEWxYGkQGhtEjuFdLgI7YzMeV6iDG6d8?=
 =?us-ascii?Q?rwZn+3F4x21HxLN2+z8A9auVkCoUcSAwDvJAAZIf9lm4+7duc1Afjd6Qt1Oe?=
 =?us-ascii?Q?WqjpjJOcdlvNMs3uygQUMBNfmueSYfpj+bJM3XGfREQSUyKe9JO2NGrqLP3i?=
 =?us-ascii?Q?57QkjeUkHTbGHRTFxg5WJFxTCs6+ZkOP6VaRShpJneki4iFoj2jB6RgWg4h/?=
 =?us-ascii?Q?3kV8aLRVgLqe6wgq9nGSy7F1cL3Rwa+NK6KsWG+j+mvq6FEeN5rakhE4e9Fc?=
 =?us-ascii?Q?Atxc3XCOvHk1KLPqj6GyNYkSi6hQH+Vu25gwhcuFrNOWMXUvz6x6qfmJO5zO?=
 =?us-ascii?Q?rmWdmqtQx2owxREhj0v40iZOKEGBU9gxRZ/QGDKbiWp1zq7HDaGN2tXHbyAB?=
 =?us-ascii?Q?wPF5A2vNybvhyAm70xW8JDeWchTNuQqkTMAoOIiBd81gU+MWxS+vDnWw1YM9?=
 =?us-ascii?Q?cGzhgSrVECjRCNp/N1UTez9HD2tVNcedvpPXK17sl/75H9ZSFvkO3UlmzT/w?=
 =?us-ascii?Q?3HJE04/GMGpgb4hnrlRHVo5JBQ/VUSuRnkqgG6BsFT7hjmrHhpx+C8edxQFQ?=
 =?us-ascii?Q?zvFpfuvqZh+LcL+kc9p6R1t/FE2O+mtjGDf6PFkhzxn0ggYgoN7lreQIoXQi?=
 =?us-ascii?Q?EgadsNRcJdviWJ+YTR1btNp6T0+RWs7JSPkQg2hGMKprcao6xp11tXNtkRwW?=
 =?us-ascii?Q?HdTbbxGSqf042oCJDzyLhxHPwM8zs/TI+yTrx133Sf5JunAUdF2xhcaw59Ek?=
 =?us-ascii?Q?vdUmzbUxZgM+FPgpR5uEk8KN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <631DA27F394D864388E02AD533FF6DF1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dd4fcd-1366-434c-bc6f-08d8d74241f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 14:58:04.6599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +M6mMPRtYCTCCfLymrBwivA373CXSK/X29IZnJjTBfG3p4G3v/Rqb7KUN4J6IyUXwrYChTbcEI8ON/VCZAJzhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3030
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220139
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220138
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 22, 2021, at 4:35 AM, Mel Gorman <mgorman@techsingularity.net> wro=
te:
>=20
> On Mon, Feb 15, 2021 at 11:06:07AM -0500, Chuck Lever wrote:
>> Reduce the rate at which nfsd threads hammer on the page allocator.
>> This improves throughput scalability by enabling the nfsd threads to
>> run more independently of each other.
>>=20
>=20
> Sorry this is taking so long, there is a lot going on.
>=20
> This patch has pre-requisites that are not in mainline which makes it
> harder to evaluate what the semantics of the API should be.
>=20
>> @@ -659,19 +659,33 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>> 		/* use as many pages as possible */
>> 		pages =3D RPCSVC_MAXPAGES;
>> 	}
>> -	for (i =3D 0; i < pages ; i++)
>> -		while (rqstp->rq_pages[i] =3D=3D NULL) {
>> -			struct page *p =3D alloc_page(GFP_KERNEL);
>> -			if (!p) {
>> -				set_current_state(TASK_INTERRUPTIBLE);
>> -				if (signalled() || kthread_should_stop()) {
>> -					set_current_state(TASK_RUNNING);
>> -					return -EINTR;
>> -				}
>> -				schedule_timeout(msecs_to_jiffies(500));
>> +
>> +	for (needed =3D 0, i =3D 0; i < pages ; i++)
>> +		if (!rqstp->rq_pages[i])
>> +			needed++;
>> +	if (needed) {
>> +		LIST_HEAD(list);
>> +
>> +retry:
>> +		alloc_pages_bulk(GFP_KERNEL, 0,
>> +				 /* to test the retry logic: */
>> +				 min_t(unsigned long, needed, 13),
>> +				 &list);
>> +		for (i =3D 0; i < pages; i++) {
>> +			if (!rqstp->rq_pages[i]) {
>> +				struct page *page;
>> +
>> +				page =3D list_first_entry_or_null(&list,
>> +								struct page,
>> +								lru);
>> +				if (unlikely(!page))
>> +					goto empty_list;
>> +				list_del(&page->lru);
>> +				rqstp->rq_pages[i] =3D page;
>> +				needed--;
>> 			}
>> -			rqstp->rq_pages[i] =3D p;
>> 		}
>> +	}
>> 	rqstp->rq_page_end =3D &rqstp->rq_pages[pages];
>> 	rqstp->rq_pages[pages] =3D NULL; /* this might be seen in nfsd_splice_a=
ctor() */
>>=20
>=20
> There is a conflict at the end where rq_page_end gets updated. The 5.11
> code assumes that the loop around the allocator definitely gets all
> the required pages. What tree is this patch based on and is it going in
> during this merge window? While the conflict is "trivial" to resolve,
> it would be buggy because on retry, "i" will be pointing to the wrong
> index and pages potentially leak. Rather than guessing, I'd prefer to
> base a series on code you've tested.

I posted this patch as a proof of concept. There is a clean-up patch
that goes before it to deal properly with rq_page_end. I can post
both if you really want to apply this and play with it.


> The slowpath for the bulk allocator also sucks a bit for the semantics
> required by this caller. As the bulk allocator does not walk the zonelist=
,
> it can return failures prematurely -- fine for an optimistic bulk allocat=
or
> that can return a subset of pages but not for this caller which really
> wants those pages. The allocator may need NOFAIL-like semantics to walk
> the zonelist if the caller really requires success or at least walk the
> zonelist if the preferred zone is low on pages. This patch would also
> need to preserve the schedule_timeout behaviour so it does not use a lot
> of CPU time retrying allocations in the presense of memory pressure.

Waiting half a second before trying again seems like overkill, though.


--
Chuck Lever



