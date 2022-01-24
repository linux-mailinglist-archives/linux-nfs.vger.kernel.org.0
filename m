Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996E4498362
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 16:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiAXPRt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 10:17:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25114 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238469AbiAXPRt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 10:17:49 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OD0xkX022864;
        Mon, 24 Jan 2022 15:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9YMhRkWHICXwMHRMUwFomGSwv2KBy2U/n1Mtvm3kJs4=;
 b=EbL2S3Hpqb7IKEPre4r7uWBAkI5MMKFp6HXLZQrbhR5NX6AeTg668/kvrUBUY1Gvubou
 CM5QHJgv4iYQOxXznosDmpaHGnNn4M2OQ6bhFqMUNRg7npPjRAnRVrrYTIK62UAD2QZq
 1eqIN7SwTHClVwofot+U8sJd+V/qsBQqvBz9yqTyWYAUIZKasYqJTWRGNdbfRTaJwJku
 GMPkzsTlNV+kp2tkIOzCHRBgK51mq24LEIypkL18hYBKT72lusvBJNlFqHLsqT6cM2qz
 1leLqTkQnfc+vGuIXa5Ot/K9KUuFNf1bTYeaXkV4K581MTwnuqauRnWAorMLLiIDdRNG PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmj8brt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 15:17:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OFAiw6096059;
        Mon, 24 Jan 2022 15:17:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 3dr9r45ufb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 15:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzffHRTa9n+pFCgitEsavJRzAyCE0If8mCxN3ZqArSxYOui4L7tByX0+n6NReA4WZYrYuLM6DGQ8NenWfd81bK4bZ4TSIivVn3eFJ6F7/cWxpPvL8ZFmPRwwsszoNnT4i4DNkFEVgzlM1KBoPqb3nMeplNzN1wWBbHwRLH3UxvztRZ/kPAZ0O/MUkKAvPmiRo43JROFKkEV9SfTfnWtNQWF3AWHKhASSfGkyvN09IgaIXwN4uISaiFrzROFrbNyL8T5JS4iVxQRWHs3gIKJIX+bkil86IIwr7xrttMPRK7lU8QXtQnepAx9lrALBQyFVxl1/dAS7oaZSK/2mVDIkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YMhRkWHICXwMHRMUwFomGSwv2KBy2U/n1Mtvm3kJs4=;
 b=fUWq7tLtLqwZM8dl1pefNJ63F3+NmrUghbSUinvAlAaBbRpMeYFlFlI1ZSD5bPJHTjAlSBL0aMwJq4TrVXnbC2dMk25yx/WPuv109YWN/5wG3z4HIuuVGaE6rYLny/Jhqp968p7HGDRySXCpBs4JDfI1ZEUQtuTpAkDGvEMBCbuXYIcwgP1Vjmop0gw/FM119jh3MrTjIVuCAvfp4wgHC9Eo242LTQPTB/s3W7Cy2psFQ2sHtSgJlSqpDoN1ZqRg30GbQfY/9Qjb6XmL8nbNgLt8SUTTpPbsCDYX4c+vOsDGita/I5/2cmpnA2aQmYa6XQ9c4r1qCu0nSVdwcdl7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YMhRkWHICXwMHRMUwFomGSwv2KBy2U/n1Mtvm3kJs4=;
 b=E9P35qu1EILcV4v9ABLL/cNkXqXB60Um5A0UmifTwy30Z6il6er652ATvuPJoGpVCZeKKTIf5bl6HO9qT/A6A1aoMewtpJ11KABK+R0JLIb49L2xez+ED1Vs+/66gTHF71rMS0iZSfqz++WdYGdjICrhW0DtIhMJPhFiI5JUvy0=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM6PR10MB3146.namprd10.prod.outlook.com (2603:10b6:5:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 15:17:43 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 15:17:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: dynamic management of nfsd thread count
Thread-Topic: dynamic management of nfsd thread count
Thread-Index: AQHYETWIjqH23KS61Ea8gdX7jSVUMQ==
Date:   Mon, 24 Jan 2022 15:17:43 +0000
Message-ID: <EF3A3E35-FD8F-4ADF-AAFD-A120D83F80F5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b22faf8c-4eea-4582-4681-08d9df4cab7f
x-ms-traffictypediagnostic: DM6PR10MB3146:EE_
x-microsoft-antispam-prvs: <DM6PR10MB31465EC2AF7F90E30CBE162A935E9@DM6PR10MB3146.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p1PFxobzmOry3miXJjTWT3bwdD4GWOJ+W6QGHf320Y1AoDvVo9Vq8RvBzUk7Ute2z3JwFuwRHvKFl2obnHNheYRq/F2/c93cubAb2nVGcmzp6LxcpdMWxP7F1D1GLRfc7sqHWBXeqle/yJNcwB3QOsv9G2YPEVVDxHzMr2NoUMaLnpDAAh3PTouQCxjOuRYyzJIMKmhYZ33bT4+lWvBt7cm74nDGczaa7wTMdRl6asKYC+VUqcus+zPSufkYjcEpgeKmqcg0L9qkmscgaTmvwzL9vk4zpJsf9UfMPhH5qsTPGJiSfHWrfsX2BWCHaIhuS8tr0UYpU9JgzDA/gaxuyN3avZ9WlO7S4HjPjkML43wualr9ZRgAvII2lRI6FX4mXSR3NwEpFlBp7jN+vBM1ZTyB6F4B2sCTa8WNgyBITUonS/XCemxpGZAHM7MFW9Sbz8Q+I+yfM3iaZBMyjp2a07PxmUkqPdaDTYGQJaUCG9essIctAqTz7jiTH2E49VwpXozaTnnNBZCgKp/3ufsK3jOkI5sXaLja/y8t611YHbAN1OTZFKiCJXX0DJTz2XkZBxOMWAIzzU/97tleBUbxhBnsnSCJqjyN3xWLdznzEV8slkaoMOhDMYly/QBeCaG8GmsNdr9mDWimTmUDx40OjdpU8JKIestQYnHtLHjYom4UAQ121pl9k+vpUWrE02HmRgLRKMyybgb06gzImhBRp9aKtgtGR+ZdPnZ9s2+Tjt/cgUkH2APsl6Zs5XUq+NXI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66446008)(66556008)(6916009)(66476007)(8676002)(6512007)(5660300002)(33656002)(316002)(66946007)(26005)(76116006)(38070700005)(186003)(508600001)(6486002)(2616005)(38100700002)(6506007)(122000001)(36756003)(4326008)(83380400001)(2906002)(86362001)(71200400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nt+JRGhAHkh08sKHqQFB4qozkNfs1zrBDaJl861/L0lXGaE6/Sgby8+NrCJ0?=
 =?us-ascii?Q?LhGVWRr1vHs8FVniVx27oqN9g+OBMkCDhGLRQBIVMMIqSGNdwHSmCZvn5sOw?=
 =?us-ascii?Q?yIJAIpZ/9EwQREY28UgjFDvGC3UQO0CTSgwWmumKogxme3yblhUC16CX6sGL?=
 =?us-ascii?Q?qrXMbjdXl5zGHDY4HAXYmO8QgEYWFoFQPZbL2gP18/B09G+KYIc+pLew99Wy?=
 =?us-ascii?Q?WRkR5HhukxroISVee8A1hGJz+kjUxdEeMgQjS3MoVeqQtoAs4wL/lp885XRZ?=
 =?us-ascii?Q?7jiU4fH61b0gaw+hA7y0R4kjlkb/1btyVOH1ZCei9viI1lJBIDOKS8OZHoXx?=
 =?us-ascii?Q?zJO541VF1gH9ea2/4F7GfcVVQFcWmX8Y/XhCxbIUjzkYZPvGyhodY4VaoIY3?=
 =?us-ascii?Q?+x/dDywhqdRsX65fqLqepjkbMP6B7BQWl33XGP9EfTFmfXD/3eAHFhRM23y7?=
 =?us-ascii?Q?1+aa+5NclfZp5EL6Uf7DeHWmECqU+ADg9eacvEnklrZr8quLRoGUFLWh2k5X?=
 =?us-ascii?Q?eKQXMslesZsEY78hSokdF437CO+UtQMEptIcU09fF3sqXlklLPelmnhDwh3O?=
 =?us-ascii?Q?lVXi6LlulqV3zdGUkB/9wb5n3xL4psI6EE7CDfmWp1C3XTC9Q2vHWXu8TjHc?=
 =?us-ascii?Q?gUkmbGk5tmrhybPIOB3v7nMP8m4ulJj5b7uolK5fnx5+/Sgxo3ZYVmOCiMYs?=
 =?us-ascii?Q?9UnX3Us57GwDjI6zmOTMrr6Im2DjeCx6tnNAxHan8xb15WZdl48ZoXKCb5zW?=
 =?us-ascii?Q?v5cPFT5FcoQkbzsLgFHWgazprz2O3npgJen5E06P2/Ag14sZEz7VTbVasvWK?=
 =?us-ascii?Q?9nzFFxGcJRx7ciKyF0sfvyDerUPz3V124LGaQtIXPKfkWgJsvlRoX2/IZ8fj?=
 =?us-ascii?Q?6lbU/PXDG39qgatngwJmoUesVwPqMD2uej8K9GVFDSHOADpWPIbpUG11gKen?=
 =?us-ascii?Q?v5rodqXVwiL138cUSvVvrh6M1b3FgbfK7ak5LWW/l2XITujq2fbDwflbK887?=
 =?us-ascii?Q?5ahL+yquxMh2G/58n7zamZ+BGXy8rcv2uAfaLc2V+8/4H1gl+pNTOU/3y0HX?=
 =?us-ascii?Q?6zVb7zLuzPwbOaYA7+aZt/AiSoHEv10NPOsXSs4Z8BZAUnjDjSdyTIdijwrV?=
 =?us-ascii?Q?3ftsFA7lwz3ECXQGHzBqeYmTXU6oN66zymPqUT/NUdaha/ApQaTWyejwMFCe?=
 =?us-ascii?Q?oMx6S9dwaF+HxCdFmKRkDUKloFebOGSpZOHSlOs56K3O3yQXYgJXbIOo8+c7?=
 =?us-ascii?Q?PmMaKR8MhfWVva9l6M611YiLfgPmPXKlOuzDkACzgQKQu2daXjeDlxeaNLSV?=
 =?us-ascii?Q?B9vUj6VVdeSgiEG533f6izoIR/t6IEz196CJzKuc+EdVgc78rXpvpkKVeBvX?=
 =?us-ascii?Q?tzoxMVNGCgKjpPUctATgC3nT4N3LcRl3mltCBIwvON6aJ4jkef3uH/rtE/6D?=
 =?us-ascii?Q?wGNHgvwOpNNtlS9/BPu5mOXLAKYrFlivuGi4XreGJ2NaV1CVmI13Vvo+Qhq2?=
 =?us-ascii?Q?iWlfBtRWasnZBOx2TCECg+jAUGSf8GH49/ILw/yiDHORtDKdlLf/RAmPK4xt?=
 =?us-ascii?Q?c3MLnrfZb17z9oypbcBld6RBgp7i3SOesfxt5J9g5TCSrK0ohu/X0pbfUt11?=
 =?us-ascii?Q?K2czj4q1sJZyxxhhH62t83g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33D1EC00DB7DB748860969B12C145B2B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22faf8c-4eea-4582-4681-08d9df4cab7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 15:17:43.6139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /A20VBPGvXr7n380K7cZqsrH5TQJpeJgPxR1aqWlxeUzazvqJH4qhPQfQUV+0c8Id4YyuyjxKRTFbQOpA698+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3146
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10236 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240102
X-Proofpoint-GUID: yJ9tsd6K_Vgi4ZKe2O1cb_PeXEXNTWHU
X-Proofpoint-ORIG-GUID: yJ9tsd6K_Vgi4ZKe2O1cb_PeXEXNTWHU
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

The clean-up of NFSD thread management has been merged into v5.17-rc.
I'm wondering if you have thought more about how to implement dynamic
management.

One thing that occurred to me was that there was a changeset that
attempted to convert NFSD threads into work queues. We merged some
of that but stopped when it was found that work queue scheduling
seems to have some worst case behavior that sometimes impacts the
performance of the Linux NFS server.

The part of that work that was merged is now vestigial, and might
need to be reverted before proceeding with dynamic NFSD thread
management. For example:

 476 void svc_xprt_enqueue(struct svc_xprt *xprt)
 477 {
 478         if (test_bit(XPT_BUSY, &xprt->xpt_flags))
 479                 return;
 480         xprt->xpt_server->sv_ops->svo_enqueue_xprt(xprt);
 481 }
 482 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);

The svo_enqueue_xprt method was to be different for the different
scheduling mechanisms. But to this day there is only one method
defined: svc_xprt_do_enqueue()

Do you have plans to use this or discard it? If not, I'd like to
see that it is removed eventually, as virtual functions are
more costly than they used to be thanks to Spectre/Meltdown, and
this one is invoked multiple times per RPC.


--
Chuck Lever



