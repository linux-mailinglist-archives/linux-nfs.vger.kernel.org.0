Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890334C8EC3
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Mar 2022 16:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiCAPRi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Mar 2022 10:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiCAPRh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Mar 2022 10:17:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A1DA88A3
        for <linux-nfs@vger.kernel.org>; Tue,  1 Mar 2022 07:16:56 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221ECsvJ027257;
        Tue, 1 Mar 2022 15:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XGffEqoRwTnXRoK+JnRywFZjkmeNxVSkCXaFvgbxJwk=;
 b=TGTPr/JF63A/tpL685R/RenFtliqqft+NzU6gvnGO1zop2DT23z9V75SmyxyZ6SWnQ1F
 NQbHNqkXiLjVGk02tcDYPowN5anWat3komRNqrqv+CohEZqg2TprEhe9XgN0hHxkgpjf
 ic6FhBsJw0skXgR5/JcI1itpuxNgKIQO1NYHTq+It8n9GfldSHzbKJmPZT80sFFE6HGy
 GalNEqn7GX8+E9fqccJ2SCRKJk1DkAWI38rJo//BW8Ame9cnMyA0120TfaXbEUMMXGWY
 FiU+cEFoh5Fak7DPzp87EQC+noiGDpFZyqMiDDsnhStNHcvvgGB/kHbZfnESHD/MHvNy Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15ajygt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 15:16:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221FFxXU071098;
        Tue, 1 Mar 2022 15:16:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3ef9axjh0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 15:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WknN+owYW1ahheCA4TN+nQzg8h68yBYKJX8gJN0LCmfrvkW3Tx4tpF6lZlI+W6cU5GMPtvSoiEQR4oDf2JKthGzylpEadIJYZDhzjExtmPU4BS1i6oktIyJIwJ2ua1+zu+xKZU9+Zeu1KC9R6SCbPnYLKeOnTPZ8xioVGKjjdnAWeFQz7bi9WRvSKhYsdHv7kRrN3zpZqwgJ75nDo6xbdEmkcPmG2CK5MHkM3+2Yaii8qOEVoCvcxbpfGngpWkVmkAtoOIPtGXYV0in4umilNXdatx3VfxGGXT0TG3r7s7vs2RI3hHosgYptRWtym1eoWqrBeJjN0A2pJTy2QpXvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGffEqoRwTnXRoK+JnRywFZjkmeNxVSkCXaFvgbxJwk=;
 b=i8PZFbHxIhGIUI+8st0WhVIAgSqzZH2xvbR36eKkXYNMjeAr1FapRWnGXyww/e9U21Cp3Wfrul3pKisbUuz1lh/zKcEY9ZzA/hagLdgywbeVlpe/jBM6AVGwlHRXOHZ8Lg32OMp9Ega2fMJL2jVGQDuftmtYAK63idYLVhEErhiInkCYRH+WQsftvfGFL/kccfZ2PBgEYIcTHFg44qyUhOZNumRhnzBdCLeLtcXvToAfEqXsUtuixk1u7q5YwbNI7L8AiRGRkJY3AOewVio+roSO2+git0POOCTxK6MHDtc7C7PWXDDPsI5DtI6HcgvYqwSMinnODDqJtFUDAKk19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGffEqoRwTnXRoK+JnRywFZjkmeNxVSkCXaFvgbxJwk=;
 b=vrA/YtcYdNUtIfU/wns9r+fUd9gUWbRLWR5iz7u4LgbMo5Kkr0fWuP1afy8ihPbmcF7T6vX5sGPoi3ao3evi1cApw6WBlRrFO35KkLZL6YQvvXRiDb6l6jXYoD1gx1xauPzzcEtuH6PQjVmY4G1bU1QT9yAwHp/wgrYzLTkoaDM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB2923.namprd10.prod.outlook.com (2603:10b6:5:70::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 15:16:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 15:16:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Topic: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Index: AQHYLR6czeCutPWqYkWZgIa/iwKGvKyqohqAgAACZIA=
Date:   Tue, 1 Mar 2022 15:16:48 +0000
Message-ID: <E3284CFD-CD24-449F-BAFF-FBD49FDC4525@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>
 <164610623626.24921.6124450559951707560@noble.neil.brown.name>
 <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
In-Reply-To: <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92ae78f3-4906-42db-84f7-08d9fb96813c
x-ms-traffictypediagnostic: DM6PR10MB2923:EE_
x-microsoft-antispam-prvs: <DM6PR10MB292314FC858E5FAD233C3A4F93029@DM6PR10MB2923.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XNVkZoY3rMoGEmfpuqMxV8h0y4ifxHs5o3fTyQnBbeKQStCG2IK6xU7GcdvlbQGpegKREa9DHHvIM0W/XRCuggN4Dow3kWYnn83rVpWZVABiUoZ/TsKCF5f7uS2jwg+EtgyTn0w9UcRPwMgZOIvcRNzIagEdWqN1ATrbKZIQPNWDBTryoCaSzuWiTAjltZQIkC2tuAEyiIG9kmB+rqFQMG+gxGcjV2AiXpT+jPot1/UxOzrMUQ7b0VvvGU//iVTrVaLhDgnEWWpzYr5gSRHwx07EpqSHawHek/VYzwMhKHuN4om05t29I1DLQQ5bDTlbO0prCU6ClZOAZ2HE3iKMNu56YKuxv7cSVH6F7G7PwmT5YJ0trx68p8aEfgryqzwwIJzJ+zlXbPuhBxl0DQ4FXf/+79FqWwY9LzQkEhgvt4wEOIk3pfH3T+sJS+v7TpTUnPaBar2rPVOx52y0/McNRYA0BRBpl2JNZBgp39hBF23N6UAJ/ULVJd30GZdgIpBVLbXvMTOOhmxfLAErTaEvo1dy9zo1uBC4okbFtF5yCgh/5+fqSgcL+FPWX3Bn0oBfKwdQCkx0HznMmyJkBOF3N1npQPSzWib3TSeGqIY4lhD+bRZHs6IFEdhgMM+phk+PtZFET08jVkhMkVksQ2Q6OxjgrIH1xqOhsnW2SGfSH9OE8r9izqh7uIN1dPvBIhQAKio//kpCGK7w4JEiAQA9XuJBSJkXiV2VbzbiK3AkIErXM6PN3QFH60amGo+Tlmd1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(91956017)(66946007)(64756008)(66556008)(66476007)(66446008)(76116006)(38100700002)(122000001)(2906002)(4326008)(5660300002)(86362001)(8936002)(6486002)(33656002)(6916009)(53546011)(38070700005)(6506007)(54906003)(508600001)(6512007)(36756003)(71200400001)(83380400001)(2616005)(186003)(26005)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DZ8xgqyHMWzoQuxv74NF92vShNyV+ToyZKSxZ3y29Drn073vr1EvBX+wHypO?=
 =?us-ascii?Q?VJO+Rx3GROJbelPAeNJGA/ms6g1E9xgALw07u2W5ZsiGjD0mRjkdKgDvEHtD?=
 =?us-ascii?Q?KEIboe5blPBnnKUVCzNfzqlhkh6zOtLugPUshz+pyFr9ngweji+dvydJqU8a?=
 =?us-ascii?Q?0O/JFtivdTeST/sl2RDOXNGVUvjuXTo2sWjJ138Iz+WRmeZ7dKEOEgXsQpR0?=
 =?us-ascii?Q?zvGvGNR8Xcv2DwOzfALPtlQHWNq8blXgpwEQdWRXuIt98RdG6k1xA/cmhGM3?=
 =?us-ascii?Q?piztlQJQBHcOg9q2UONh60NBcv80C+Ua4HgSBeMga0vLd4yxaZzEU9iucJKe?=
 =?us-ascii?Q?89MoXnnvqtnP/3NYF0hU1rF7eDXIr3/QIfNLLlXQ+QtBkramY5em+bo9vX30?=
 =?us-ascii?Q?1oQq3YHUQ5y7ZRdvLSH7jFfxQXjloMEEaUBK5bOaLpbl2yDrP8SWjFDPE4YD?=
 =?us-ascii?Q?p1+drJW/3V5/3GW+Kn5FqXSJzrMdAUHNrhe1XWhb3R0Lb6oHCODaPaBSKuuf?=
 =?us-ascii?Q?E/o3ofWi5gflwXrSF7D20JNGO7z7Sk4r7rg6mi5ZzVgqycPv340pjJmpYIVE?=
 =?us-ascii?Q?S8F8cVjrWCzxo00ZxaeLObrd3Ru9kUf6RWCzURkf+dtQnJuU0DDZ5noOrpOj?=
 =?us-ascii?Q?Mw9oKnDfXwDtXXzvmUJ154YVVEk/+Dx8H9WFnHaH0XtLuXRcSx3hYmkuts8A?=
 =?us-ascii?Q?0ebJ5ASCH32OPe2pD+m2kevwrGXfosMQTKssGGUq1BDIDPBINQfGuRPiNgWk?=
 =?us-ascii?Q?84teHb6epvfA5z5DG3Qufd1tcWn+6h+rEWq8GNrocVTRzGCT8aqSy3o8vis4?=
 =?us-ascii?Q?kN+geShtPtXYb2ODfNBPW9xQndIjs2Q0dlD2V52HbeB5yW/dZOC01kPJ5USR?=
 =?us-ascii?Q?6lgh1+NZfHemGFw6b0taM7J/RC37VY/GADr0ELilGrba1SGIpFVkgWx6bVgL?=
 =?us-ascii?Q?GueacK9MeL40jgH7MknWr8IYP65tmZfIBc5LjishebFecpFJ2J+dgq7wcPDf?=
 =?us-ascii?Q?TFCkzQRHq1X3E5YOpIqMuIYzUieqtZIJiqmbxOydSwItNAb+9dcNCM20k+7t?=
 =?us-ascii?Q?cxZnfjUOKOvMLoJ+cEjQVqMPiMHwHzSrxllAnv5SxDFs8lkkMUrB090PVXVd?=
 =?us-ascii?Q?F/wEXuyMLW7jmDZcwRmryMtxazr1z0N2mZ9rdqVV6k2XotR2MVPhQDbpabe2?=
 =?us-ascii?Q?4jZ028q3Cyo5BhBGBBpPOgsqAQWfvU9UaQ2EYi2jP56kqBOGbPbgUw02+n7J?=
 =?us-ascii?Q?PYPvHtsjb+c41uGpeapnzj8sqhxVAJvq05aFRjX19qZvmeYPuCQZjRfHHzKh?=
 =?us-ascii?Q?jfoikaBSmzx0JD0WsuF7NkPiY6AwdWDNI20jeIxed905GJn8AYcpupvyrkqi?=
 =?us-ascii?Q?DBx6zm+x6cjWiNFYgsmlkp9WzEJ2LgD/SJtHVyt46TM+uZU/xNco9uD9jbOL?=
 =?us-ascii?Q?xOFO7LXr8k9fIN1SFdggG3wVwOqFD55rfkTCZYuhNvSDTDiGt/Ys4dB7QIv4?=
 =?us-ascii?Q?iMgIoMLXY8Ek/QFgE0Wq9yNuTmbTn/qNlXC7eRjGRw4NU17wM77uYDs4ILg5?=
 =?us-ascii?Q?z3TtrQ12nxtLvBOToqUrAeVjWNT3puYoelwcIOTFhS4xGhuQPViSK4281PDI?=
 =?us-ascii?Q?EZcYmLRx1nuOQDBUWK6ESUY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC973B93AABD774EB5E1AFBC70DAC3CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ae78f3-4906-42db-84f7-08d9fb96813c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 15:16:48.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuYSbvr9nZEXupyanzxR4NUayWw0lYW+sJH5S3SaEjGWk3CtNbTUOdclRjMUEEHhbKYyhAqsrt2+VWxo81IXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2923
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010082
X-Proofpoint-ORIG-GUID: NPpf2k2KyS8IZDbFBEkNfkmxEn9aVAWr
X-Proofpoint-GUID: NPpf2k2KyS8IZDbFBEkNfkmxEn9aVAWr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 1, 2022, at 10:08 AM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Feb 28, 2022, at 10:43 PM, NeilBrown <neilb@suse.de> wrote:
>>=20
>>=20
>> When mounting NFS filesystems in a network namespace using v4, some care
>> must be taken to ensure a unique and stable client identity.
>> Add documentation explaining the requirements for container managers.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>>=20
>> NOTE I originally suggested using uuidgen to generate a uuid from a
>> container name.  I've changed it to use the name as-is because I cannot
>> see a justification for using a uuid - though I think that was suggested
>> somewhere in the discussion.
>> If someone would like to provide that justification, I'm happy to
>> include it in the document.
>>=20
>> Thanks,
>> NeilBrown
>>=20
>>=20
>> utils/mount/nfs.man | 63 +++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 63 insertions(+)
>>=20
>> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
>> index d9f34df36b42..4ab76fb2df91 100644
>> --- a/utils/mount/nfs.man
>> +++ b/utils/mount/nfs.man
>> @@ -1844,6 +1844,69 @@ export pathname, but not both, during a remount. =
 For example,
>> merges the mount option
>> .B ro
>> with the mount options already saved on disk for the NFS server mounted =
at /mnt.
>> +.SH "NFS IN A CONTAINER"
>=20
> To be clear, this explanation is about the operation of the
> Linux NFS client in a container environment. The server has
> different needs that do not appear to be addressed here.
> The section title should be clear that this information
> pertains to the client.
>=20
>=20
>> +When NFS is used to mount filesystems in a container, and specifically
>> +in a separate network name-space, these mounts are treated as quite
>> +separate from any mounts in a different container or not in a
>> +container (i.e. in a different network name-space).
>=20
> It might be helpful to provide an introductory explanation of
> how mount works in general in a namespaced environment. There
> might already be one somewhere. The above text needs to be
> clear that we are not discussing the mount namespace.
>=20
>=20
>> +.P
>> +In the NFSv4 protocol, each client must have a unique identifier.
>=20
> ... each client must have a persistent and globally unique
> identifier.
>=20
>=20
>> +This is used by the server to determine when a client has restarted,
>> +allowing any state from a previous instance can be discarded.
>=20
> Lots of passive voice here :-)
>=20
> The server associates a lease with the client's identifier
> and a boot instance verifier. The server attaches all of
> the client's file open and lock state to that lease, which
> it preserves until the client's boot verifier changes.

Oh and also, this might be a good opportunity to explain
how the server requires that the client use not only the
same identifier string, but also the same principal to
reattach itself to its open and lock state after a server
reboot.

This is why the Linux NFS client attempts to use Kerberos
whenever it can for this purpose. Using AUTH_SYS invites
other another client that happens to have the same identifier
to trigger the server to purge that client's open and lock
state.


>> So any two
>> +concurrent clients that might access the same server MUST have
>> +different identifiers, and any two consecutive instances of the same
>> +client SHOULD have the same identifier.
>=20
> Capitalized MUST and SHOULD have specific meanings in IETF
> standards that are probably not obvious to average readers
> of man pages. To average readers, this looks like shouting.
> Can you use something a little friendlier?
>=20
>=20
>> +.P
>> +Linux constructs the identifier (referred to as=20
>> +.B co_ownerid
>> +in the NFS specifications) from various pieces of information, three of
>> +which can be controlled by the sysadmin:
>> +.TP
>> +Hostname
>> +The hostname can be different in different containers if they
>> +have different "UTS" name-spaces.  If the container system ensures
>> +each container sees a unique host name,
>=20
> Actually, it turns out that is a pretty big "if". We've
> found that our cloud customers are not careful about
> setting unique hostnames. That's exactly why the whole
> uniquifier thing is so critical!
>=20
>=20
>> then this is
>> +sufficient for a correctly functioning NFS identifier.
>> +The host name is copied when the first NFS filesystem is mounted in
>> +a given network name-space.  Any subsequent change in the apparent
>> +hostname will not change the NFSv4 identifier.
>=20
> The purpose of using a uuid here is that, given its
> definition in RFC 4122, it has very strong global
> uniqueness guarantees.
>=20
> Using a UUID makes hostname uniqueness irrelevant.
>=20
> Again, I think our goal should be hiding all of this
> detail from administrators, because once we get this
> mechanism working correctly, there is absolutely no
> need for administrators to bother with it.
>=20
>=20
> The remaining part of this text probably should be
> part of the man page for Ben's tool, or whatever is
> coming next.
>=20
>=20
>> +.TP
>> +.B nfs.nfs4_unique_id
>> +This module parameter is the same for all containers on a given host
>> +so it is not useful to differentiate between containers.
>> +.TP
>> +.B /sys/fs/nfs/client/net/identifier
>> +This virtual file (available since Linux 5.3) is local to the network
>> +name-space in which it is accessed and so can provided uniqueness betwe=
en
>> +containers when the hostname is uniform among containers.
>> +.RS
>> +.PP
>> +This value is empty on name-space creation.
>> +If the value is to be set, that should be done before the first
>> +mount (much as the hostname is copied before the first mount).
>> +If the container system has access to some sort of per-container
>> +identity, then a command like
>> +.RS 4
>> +echo "$CONTAINER_IDENTITY" \\
>> +.br
>> +   > /sys/fs/nfs/client/net/identifier=20
>> +.RE
>> +might be suitable.  If the container system provides no stable name,
>> +but does have stable storage, then something like
>> +.RS 4
>> +[ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid &&=20
>> +.br
>> +cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier=20
>> +.RE
>> +would suffice.
>> +.PP
>> +If a container has neither a stable name nor stable (local) storage,
>> +then it is not possible to provide a stable identifier, so providing
>> +a random one to ensure uniqueness would be best
>> +.RS 4
>> +uuidgen > /sys/fs/nfs/client/net/identifier
>> +.RE
>> +.RE
>> .SH FILES
>> .TP 1.5i
>> .I /etc/fstab
>> --=20
>> 2.35.1
>>=20
>=20
> --
> Chuck Lever

--
Chuck Lever



