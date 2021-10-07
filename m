Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5E425B90
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhJGTgD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 15:36:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52202 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234732AbhJGTgC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 15:36:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197JCKrE026145;
        Thu, 7 Oct 2021 19:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=a51Mr/BR16d8vvZAQls2WvpaF8j+B1Jo99BASil6r9A=;
 b=RvNrSjwmG8eHkjtMQXs2441V2360h/SqonnT6J6nouFwF8IBrABLsLegq5+/Ky4Lvtz3
 1UAYfPXhkHJWFIn/yt4P1+1g0QMK0LzPocLiuc2aGvfSnRx2Bmd5grWDJeUTQ0CUhXLS
 3anIh0QCqJLUDoGFTe2Sm3Tolegn5id2lIhnZpxeD6+PNP2EG4ou+wNt4ggKoyKJqYxP
 xOFpcV20fvohmMeyerMz6GDlZ4eNv3BNy8mTnfsX2O+//kAbDldCvY8cclkEqD+aVcjl
 zCleW6Q11PYr2jat9eOp/LiVmi8VcETcYwMVQaErmtoEZOdG706EzcikEyDLqIPpBJKg 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2dbp71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 19:34:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197JEotc072951;
        Thu, 7 Oct 2021 19:34:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3bf16xc9us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 19:34:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMtLE1j4pNnzasy37s3U8MXP5P97Xlmhva68NVHUkfZis00fXrhuyud6/+ONx5BKAJ4mjberY5O9JvKusZROcDIsVbTCIYsDY5MJhskrBv6en3iJDan00e51U9AWWvsrM8lXYEu8Y/iJLrqsh+JIKV+6SfCmVOpyWqj1AN6OMI83rFEjXpR514RS860JUrSj5UO07gb33vbsDcaEpObJTA5tqca/PO49e2BMmFPETC2I8LhkzTk2wJ0Y5fqud9IZKBStf2LyB+6KN6kK2ikxtkXB5Te/bsohdAmfCWnyctbZQA8MXtp8cGVgX4+ETjOjDnltM4Ib8rdTZjFwX8MXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a51Mr/BR16d8vvZAQls2WvpaF8j+B1Jo99BASil6r9A=;
 b=OXJMTy5zJ2rQ2e/TBAib/8qAhzAXQgTmf7YkDVRY7KR6+H56oPuuJH3+8Ab3TauG8wtUUCOmNa2Lcn218npL9TPyUN0m58561HKMVgWxhJPjXF2ovWnyMRH6suQAPmvnJp718XBIzg5F9OIETqlAGsBXM7b+FHsBBeFPP6Nbe0W0bsb7QWkmbfUolRXGXRmjdMXjjur+cQgyYdgCLHAJ55JeTBEjsLuOJx+sxiy+AiCb0nJ/trQ0oeq2Vj/eVxIi3+TJZQMCJUM1A+2tGAXdUnyR6L3a0N3yv9npricfxbzjUmzO7FcWzX4U9NbjTETdxUzIi4XfU9YLjoVWPxUvQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a51Mr/BR16d8vvZAQls2WvpaF8j+B1Jo99BASil6r9A=;
 b=xMj/hf+adOcawoICrsD1dtDRrbdxYBCeJuukoXg8+ibLq1P8PH2GQN3MK9quThe7UYvYT3xQwr/+5dUabWMqktw/7n7+C9dNe2C4fNwTjVon0T73DKGFgTpbL+UeVh6ZUOX684sE0LXA1Wp6O1Nh42qOXSK8bkeu8eLWXxVJkDE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 19:34:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 19:34:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Topic: [PATCH v2] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Index: AQHXu5bQymWcB92tXEKQGjb5V/zVIKvHt8wAgAAwpYCAAAKMAIAAAZ6AgAAAxoA=
Date:   Thu, 7 Oct 2021 19:34:02 +0000
Message-ID: <9CEF26AF-16B2-4134-A21E-F953EE2FACCE@oracle.com>
References: <163362342678.1680.15890862221793282300.stgit@morisot.1015granger.net>
 <350A3F30-43E1-488E-9742-2FAA9F2567C2@oracle.com>
 <CALF+zOm0Ey3iRyziN3TFHRZdXfDJwF1x3YuZuksLdvPdF8b0cQ@mail.gmail.com>
 <F269CA7E-BBBD-4CBB-8C82-25B945D8C4BE@oracle.com>
 <CALF+zO=BE7BjKkF8ft+oSgCmdcatheD4oevt_O49d58g0Qg=Jw@mail.gmail.com>
In-Reply-To: <CALF+zO=BE7BjKkF8ft+oSgCmdcatheD4oevt_O49d58g0Qg=Jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 673b39a8-ca6a-4c2d-498e-08d989c96ab6
x-ms-traffictypediagnostic: SJ0PR10MB4624:
x-microsoft-antispam-prvs: <SJ0PR10MB462427D09D5DA66ADBBCAF0F93B19@SJ0PR10MB4624.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/lB9/W6dhcG8A50DL9bVqaaYIKviNYixdOCLlH7szeVtYTkoTssgCzb/i6vMwMD17b48MziUDxWmk31NE7Y1mpny8SHBTwMhSHdEPRbz6b1YjAIV3zB0rZGQjuWufJ+miosMuvaJzm2TcjXgT+7FV1O8yRz6xA9LxjDnuu0foZPXPzwWjybvk1EJAM6Rjp7XtbGOM7SPjH6zSFinZKbLfZvmaQy8OOkoObXLnySWQ56u+zhJZHyFXCpdqMChGGawYCO3SoiCEPJiG/ud3AUpOjd82kKalq08AQbvomI/Fnc7o8KceK2sbwSl/5b2E2g/L9ZZ6XJuEA/Rnb2GlvswMMwYEymoXe1OnEXX0sr0t8fKPOmlmawAw8PfiIJaZn0+scyuM+81PtIFpO9piXDcysK+Qleov3zW1Q573Z4QWRg1vWbBreiVo0JjMzemzHGNBRvN4fjURzdfyvxt9U66jzDvKdRnvF9b1YPh+1H0w6GU54twkFqDG8pOvT9kSWMCjhc6ygFyc+oMUIXk3Pe8LOsnL+Zg/AqV1cqSJlJzS2AygYJ4i94vFpcPQUNtfXTQW3nHDFfWumqiBC2Qss26miRa2wpKKl9+jA+WSiaRVmJASWyGqXC8QZ19gxQHWD86XDitMsEeI0vFn5+VyEUva8tRKG+INoP9za7zXpgUmWllahc0eIXUIfllWgz+hx5Dimmr/n1+lPrHew7aLpYSM95e13xThRDjysQO/h7qvA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(6506007)(508600001)(66446008)(64756008)(66476007)(91956017)(6916009)(71200400001)(2906002)(38070700005)(6512007)(6486002)(4326008)(53546011)(5660300002)(186003)(76116006)(316002)(26005)(66946007)(38100700002)(33656002)(8676002)(86362001)(83380400001)(36756003)(122000001)(2616005)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y5uCZW0TWMgfZTSG52sk8QUmDqQvLCEMrEq+wKLZAhWWsyRHbCTTRa+SRFD9?=
 =?us-ascii?Q?AW62CcIYc2x7RUK83BHn+3O9AOSi3djSoOVTLmXRs7oxO826V2FeGJ45CCPo?=
 =?us-ascii?Q?0ZAMi2B9obGwW0FMpQSLpuJ+Obj7Ef65Tz1y+nK0A1OYKEdtJZvWS+5QxtKN?=
 =?us-ascii?Q?NfTA7xulLIv/cgH8uPOigA3cR3D7bAhyIjdw8u4BhmEobeUtkDEcGb87fvPp?=
 =?us-ascii?Q?vnKmPpjfSDQqRPJrA5akCtrtr/p+XQeX4f0IKdE6U94/Ut6XO3fipt8TEeg3?=
 =?us-ascii?Q?ESisDLtn9zGyQ9HEMT3lYu/mAXi/derMZ49UIoyWV4yUpIg2S9wj3iTmh7uY?=
 =?us-ascii?Q?3TzFnS+qFgEKDDv3mfm72MAHOLJTfIaRLMdZe12KlMUL8cJF/9K3dJoSFfO3?=
 =?us-ascii?Q?w3mPxFvMbdl5/HhIMY+o9y/skn2WZNMtntYxqYt3ppTyN2ZjpCtx21/hnGT0?=
 =?us-ascii?Q?ZaprE3uUWwiZ3xGfXpYb4msizlrWck5JNCUsx7DmJz/aLjcxATnsqPEgCM5t?=
 =?us-ascii?Q?qGqpb4ZtbjQlU8B1UtlswhZTyeo7OLVFhAQGbG0Nl9vkgWQtxJPH7mA78wsd?=
 =?us-ascii?Q?9Kor1bkHid5v+z/IfVeTOpg/KrPSiln0agnT+6h7A/tr2oKHNAkRQQxy6hMA?=
 =?us-ascii?Q?AXYx5sNM2pwwYEuGRnU1lwE+mPLVZc6lzFyANHUOq3Q5SoaV9fZLK72TImhz?=
 =?us-ascii?Q?pjYmoQS2JXq4rYpwSdB/KSEatc7p5WtOkVixZL0fp1bRjyv99yrC88iruhnk?=
 =?us-ascii?Q?T9db7j9C20loJUekgUzyoWmmvGd/I/0s93KmBFDRJggFMOLq/mBfgmaUryRj?=
 =?us-ascii?Q?92zDzYKxJuMagU3sKEE4/9I1R9Ha8uqVeefs0SGdO3Lf2m3EUR9EHdITJPkK?=
 =?us-ascii?Q?sJhzgiS0uhOZvnXe4z9EHgXe/BDuspSdMS+Z7o2goXAihZufELec3LvLXP+V?=
 =?us-ascii?Q?pjV0rBDfDCEZX2iU4asWw9FdbOPojodJFY+o0UpbvnQWZlcWNFGH54afxtKq?=
 =?us-ascii?Q?i2KsImSv/iJIwTqHlQuuk4FutjENsHmgSVoizmos80ibU7O0DKSm6GKhpWj0?=
 =?us-ascii?Q?TwRnu4GvpUu8cYsB/KFjpaq9GILC3PVUEq4ar9N0DReK+KIyFaAQtnFYDt2R?=
 =?us-ascii?Q?V8Bcl0X8hHWuvEAW3pgOCsWYDWdDWDR0hxVOLI4BR8zOIPjTTR+UG0cKrKrm?=
 =?us-ascii?Q?0DLGsRHUB8jBNb/q0ZujgayxuriISkJMbCXxouJPM7Evpjf1f9EJgN5wwh2H?=
 =?us-ascii?Q?P8s8vP92E8EzZmDRr0SjROkZTacnV7RW6PS7t0A/b02Ma+ed8D8TRHdeihOc?=
 =?us-ascii?Q?Erj0vuM3uTYchihf60c6772P?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B9F31B8AE845E409DBD4DD9B656E33A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673b39a8-ca6a-4c2d-498e-08d989c96ab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 19:34:02.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GeivnV9fZHrv5iAmZFnLujCS4JqQXegB+dlQNJA++mlFZygIbQy8LYNa9pM0DP+ii2ViFyFuBU/TXhG/jOZIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070125
X-Proofpoint-ORIG-GUID: 1hWGcAgvfGVGpGlXhgIJ806qfypUwwsp
X-Proofpoint-GUID: 1hWGcAgvfGVGpGlXhgIJ806qfypUwwsp
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 7, 2021, at 3:31 PM, David Wysochanski <dwysocha@redhat.com> wrote=
:
>=20
> On Thu, Oct 7, 2021 at 3:25 PM Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>=20
>>=20
>>=20
>>> On Oct 7, 2021, at 3:16 PM, David Wysochanski <dwysocha@redhat.com> wro=
te:
>>>=20
>>> On Thu, Oct 7, 2021 at 12:22 PM Chuck Lever III <chuck.lever@oracle.com=
> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Oct 7, 2021, at 12:17 PM, Chuck Lever <chuck.lever@oracle.com> wro=
te:
>>>>>=20
>>>>> There are two new events that report slightly different information
>>>>> for readpage and readpages.
>>>>>=20
>>>>> For readpage:
>>>>>           fsx-1387  [006]   380.761896: nfs_aops_readpage:    fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355910932437 page_index=3D=
32
>>>>>=20
>>>>> The index of a synchronous single-page read is reported.
>>>>>=20
>>>>> For readpages:
>>>>>=20
>>>>>           fsx-1387  [006]   380.760847: nfs_aops_readpages:   fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355909932456 nr_pages=3D3
>>>>>=20
>>>>> The count of pages requested is reported. readpages does not wait
>>>>> for the READ requests to complete.
>>>>>=20
>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>=20
>>>> Well obviously I forgot to update the patch description.
>>>> I can send a v3 later to do that.
>>>>=20
>>>>=20
>>>=20
>>> Why not just call the tracepoints nfs_readpage and nfs_readpages?
>>=20
>> Because there is already an nfs_readpage_done() tracepoint.
>>=20
> Ah ok.  FWIW, you could use nfs_readpage_enter() and
> nfs_readpage_exit() similar to nfs_rmdir() for example.

Sure. I was hoping to tag all NFS address space ops methods so
they could turned on with a single command, like:

  # trace-cmd record -e nfs:nfs_aop_\*

But maybe that's not valuable.


--
Chuck Lever



