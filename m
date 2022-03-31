Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12034EE125
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 20:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbiCaSzo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiCaSzn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 14:55:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1641B192357
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 11:53:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VHoUOL007033;
        Thu, 31 Mar 2022 18:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IL7T0CjtxSWukMyY2CV7p+32uRWmVsLt0LEr+b7FTpY=;
 b=ujejE2jcd2VrMXIEA/RJ/ijZTt5BmXa9odpydsSYKQXh08xcUc1dPFC2sumNWUFIXjr2
 9Zyf/21gXx1MjPySWkq2XS5W582QzqufA0e+L7o0fDI14ogCkLkQjHSUU2zGDlJusWfF
 45hu64YZWWaiJPiwBZSuEuG3RY8VhzTM79Z9Vj274+XLOYX1M8ywJd/+ewlA5+oPW0hs
 m6SkbGkkXIFmmmYWbL7h1RAMvIPAjqDKxGhPMZsr++hYKF+zYRrRXZkFh5AapPwLj8pO
 KNqjJLOnnuISzWrCrIZ67T7umOHPmD0Tzz9FPgh8iGpbYFINt7yMNP8pFuQ9Hbk87200 Og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes55pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 18:53:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VIoa3I019826;
        Thu, 31 Mar 2022 18:53:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s95rurv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 18:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxpoUatLcaFy+I+06GysjUMsrgZkyF6YKsYYaHDpd9BT0Vyo2ZoeeSzAkh2SJuT86nxv7AR92FCSQMvn3vEb5mb7uiABGH93z0f6DvIfn5M39+cOnd94uwGuwLmTSU/zuY3hp4y4gTdgqTPWfB5xdl8gIXAyXYYFXByY+7pB5npkvzKaUt0IfN+LoghgGVgLj0JQj3xr1nj1gEkwtQl9twGV4zOjGxWJW7nmmDZsgN1LH9SaC1uf+YzA8mfgvaF5TZ8c7ZMTfmgcXtw9Na/4q4Y0QZHGaLd6npT5G2gC+ppxvtPCbmiFPL2SfDDKaszgJLNZicvD+DF3opY7bqD+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IL7T0CjtxSWukMyY2CV7p+32uRWmVsLt0LEr+b7FTpY=;
 b=gLjnTQL7PzTVMeD0A283GpibIXS8jtWUvw4HgNXt2oBSjXj/IO/xSaIVx4sbksPj+jq5DWOPpsa3UdrzVEsa/S8/V0MOFDVfSihVmDTW8+TxD6UwU+oO94dJYvTtxgrEhH87GcU8nNi5YF2RpXogfDa7aKCZpiSEYuKkVERFk26xyrnzSpuW2FfiT20JdEyDWXsqougE/6Dtri6Y0Xa0W+5iwmEseEGVxX59USuw6YXRFTgU9jAWF4iD/xc9LwltS2Hc/4mp1R+mugjHScrYeGrnz22mhxpsvOu03YxNwY6JaYWCeuYXg8kgaQ3weMqbiOF8JNyQiCFhBms9zRImjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL7T0CjtxSWukMyY2CV7p+32uRWmVsLt0LEr+b7FTpY=;
 b=PcndPTSZ0xPceDP2VGvp6bXgFKlkmofVlGybqePXXylAiVq2Ps9lN6qECw1sl6btW+E5DeABlvCS6b7pBlQOzoUWYhmGSw2A6Ysbel7Ne5ZMGGhtlTbvJlDpgnnchmN0lXw5kjfRGc9aWR0UBtIbzNCgTyYLjbxpCgA+y3vuDEU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3255.namprd10.prod.outlook.com (2603:10b6:a03:156::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 31 Mar
 2022 18:53:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 18:53:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Question about RDMA server...
Thread-Topic: Question about RDMA server...
Thread-Index: AQHYRRJNBcdkabgaO0Catodzu/oRE6zZm94AgAAKfQCAAARwgIAAAYeAgAABP4CAACmZAA==
Date:   Thu, 31 Mar 2022 18:53:49 +0000
Message-ID: <E7FD566B-0570-4D14-9936-5C737B619E0B@oracle.com>
References: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
 <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>
 <5DCBD9EB-7721-48FC-9EBD-58B7DF05A704@oracle.com>
 <8af942181abb39cd7ce8fe91be9c4c2f8c9f2c56.camel@hammerspace.com>
 <2E4807E4-5086-4F15-B790-8D952B394FE5@oracle.com>
 <974fa169124661c2ce5ed549d499837435cc7b4c.camel@hammerspace.com>
In-Reply-To: <974fa169124661c2ce5ed549d499837435cc7b4c.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8a19505-b0a7-427d-1936-08da1347cadd
x-ms-traffictypediagnostic: BYAPR10MB3255:EE_
x-microsoft-antispam-prvs: <BYAPR10MB32556617B96F5A0E190A128893E19@BYAPR10MB3255.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XN/9h0pe8qJgPfzpmrk6UosXlQYswqaS4CuiFUa4CClBwUIt5KvoXz3qwfR0DnNkJ6OdTcDAZ9RNlqgtnLB3BnkpXdvsJUbv6+wpYHtLE4I4qudIzWxcrobiRIRuw2C6QlddBE1LbytZNYq34YcwKL1VnQ8AbWBSCWGujYrW7p0Ni96TauFhl7rTVDRuFHNmlriYn4G05FWJXAZ6waulORF7Hk4R2oCQPI4CoLvp3UNQ1Q2iwfj55JbqmTUxIiZh56baFqA8JCVrazkEaijfI9lMxyX1kXNmfGzszZ17MqFzscxAASATLBu9JadXE8LZ1N3PShSVgBnLSuefAHJqTLLET+E4VyXypWW4BV+med8WqZuogvkCXhgz6hPrZjGL8NJqlzyJ5RbJ7bHcz1flb/kwa1dcty4Kuu5mb59fc8N2/Y+QyEIB27NnCu/iZU1DHTOUfg4mGQb6EdO+nKmultPZ6qEE8Zr6hEvj7WcVivFuJwZXzUp63rFIHJP7dMDt6wX8o6UNwhnp3u7upm54OH+3B8BXPn2w+F+qpgcrcYKnyMQMtkK575aEu/YHMHkuk0xVswRQJ3gJI51glJpMW/2XZPUqjg+XuPxHP028xECpPNYZaXywisF48yxWeFWYcI24/WVxYbb73JZafNwF+y2Pd5FBVRQ1tnF7ooYSUXW1LmT/HgTeplveuMEzpI7CLUsrP/StStshd9AQrCpCyrEbRnT7GhY7CXtUHVxfyY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2616005)(6506007)(33656002)(26005)(6486002)(508600001)(186003)(86362001)(83380400001)(53546011)(5660300002)(2906002)(8936002)(91956017)(3480700007)(38100700002)(66446008)(66556008)(38070700005)(122000001)(64756008)(71200400001)(66476007)(76116006)(6916009)(8676002)(36756003)(66946007)(4326008)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LMDeWFd5DjhSuWFehIEkS4LvnPTCpFo4BpnHyxDu3BQHB9QSKG7aqDZfxS0u?=
 =?us-ascii?Q?YPImlni7cBo0HMpEnUd3xaZxOL1gA5T+WVt1WXgaNF4gfu1+T4dPr0FQ/vri?=
 =?us-ascii?Q?uT/jIIZg0feBkK3T4FMrmS4qPtEegC2Rq8AWxVsqv2l8Zw3BAIk4H5x9zvN2?=
 =?us-ascii?Q?iHpoWloPHgbJXf5WXvowyzDUrjrvlPWRZpkRcyxrMwbTRLHoRa7GTgjmKEVt?=
 =?us-ascii?Q?ZlMwZ+Ov7SMvBbCBspYfXrSnDIyN1Dn+WB7jNEMvhB479sJHnJv/QvK24p1w?=
 =?us-ascii?Q?xdLlSrC9ztZpRma3aYG4mAfZErgC5T2hz+Us3fjgxNeMRSJNv6qveePUm7l6?=
 =?us-ascii?Q?gsb6Up2J1TwPasSq0BEsUksMm8rTRuUCfZtFz3hIUKa7Z0nxk49oEJ1CTQy6?=
 =?us-ascii?Q?6UjYtS7IZrBrrQCu66rA32B40wjICAp8qwTSEWuaFJ46bVMwt5UeUTBPeMzq?=
 =?us-ascii?Q?b2zSNHNIC2JO0MWxpAyZBDTsR+UvDXJkJJ6cdmgP1Zy0UYjDAhSyfTRb0QWz?=
 =?us-ascii?Q?LDuglwlfUiHmcJPY4eaqF+31wx5NjOGrAhRx4UZrhs31ZL+lpYe+0DZLAreS?=
 =?us-ascii?Q?BOnwkZH7BUhDkDYzAgwccIl5cBgPStis8CWOVj21U/am99OGI2Tun3yO1DVM?=
 =?us-ascii?Q?kusCyLE1oKKJYy/fsBe3jGNWeLwjqqL6y6l+5ESp6+PbiZtTVz8/WXOZ7piQ?=
 =?us-ascii?Q?jdO50l1REmqIO0DFAA6djhU1a+9sWXoKbFpwfeKXENMcaKWywnJp48cLUywP?=
 =?us-ascii?Q?VlYExsM/tlXhy9WRIYkk+a2jBVxrE5S3SQSqbzCSPo7FWp5/QUwy9lqdLcNa?=
 =?us-ascii?Q?gE6wrv0Phxr+T/tmckd6h06bHZMdcbvJH1ELtEao23eYqeisjXagmcfu7P3y?=
 =?us-ascii?Q?KHMinCMutqwxy/EFGpKYP9fTFT0HiDtYzt8TwAQToP6vKIKotvPfTrnuO4gw?=
 =?us-ascii?Q?DvIqj2FdT7q6sXXlwIzD5yGkq9Q93IXf7KPN6z+DXGyBWb4dUKFdoAUZ40Kz?=
 =?us-ascii?Q?lcgi5lLRkkK0ygo3y7TWyR+PP0dtl4wLotr/vb8O//2eEv0Ns/wa6NTf6ON2?=
 =?us-ascii?Q?zDChPQhw/5uRf/S2NQ13Av7HKRdpUbIWrWAJ3+SyZpbAH89niWLEgTWxr0lF?=
 =?us-ascii?Q?BY5PVOMfZCx0/oeqsPcs9lfsrtATzKHzqRM+4j3y0bg2ThonBlTwflrUNSEv?=
 =?us-ascii?Q?XOn4OLYqIKkzuOdDJV7ItoIqpCUnl7ozws55ZXEMCXq4nlnx057YCjh/PGRt?=
 =?us-ascii?Q?GuKDG+SzA7BdsYiuz7EDKf82XvJnG6AIZ/M6YNTDPWPvTeJXsHBsc/+N6QJm?=
 =?us-ascii?Q?2Yyuab2YCp5Wr1ntRVuTLyUvTOlpwqQPyhL87svfEqyJVK1Q/gIsYYPQYDQ9?=
 =?us-ascii?Q?d5euGJIWZiYy/bRUr7QHPRsq6YkywkczMYuT7taxFZXetcLJZvvOWnSdQdYs?=
 =?us-ascii?Q?dx/mXIns0P4g0fRMjiMdJmlPu3DqCSkLgXlL0ONvP3h5uXcBsCHVh8KGuLlk?=
 =?us-ascii?Q?v+rw6GhDAFhVdUMiCaxM+VLtEkdGiez6r12umdqJ3ncQ9jxr7+l8rdLTYIUq?=
 =?us-ascii?Q?PZ1BlTO98JXKUn8EN8/HYaHhbkddrFllNxODpA0wLLKUrgVs1yYpZx9ZVzC8?=
 =?us-ascii?Q?9ymf1h4gOuNpeZft6qjvGoXK17B5h6LVGT0B/r3/c/ShWT5xOLsvsryxSJnX?=
 =?us-ascii?Q?mpOIG2y+5PFCLq9c08GZeATx3GRgeaVkLjbMm4GlN/rVqpFWSvrKyJZ3pCFc?=
 =?us-ascii?Q?9xav/Fglqm9GGISRWuELazK6MRAFdTc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53ABD0A7F6A54743B6D267C5FB1FEF44@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a19505-b0a7-427d-1936-08da1347cadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 18:53:49.2658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8HS7NAMBJrO/vH7zIn3PCc4qRoJYmCy37coI8dt5RgkJ33mFlUeInCtE9j0udpyToD/G7BopWo0Z13bC9DB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3255
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_06:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310100
X-Proofpoint-GUID: Z2QOQo7nT1fcwHkEGXq7ExMZ_DqdpJDh
X-Proofpoint-ORIG-GUID: Z2QOQo7nT1fcwHkEGXq7ExMZ_DqdpJDh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Mar 31, 2022, at 12:24 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Thu, 2022-03-31 at 16:20 +0000, Chuck Lever III wrote:
>>=20
>>> On Mar 31, 2022, at 12:15 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> Hmm... Here's another thought. What if this were a deferred request
>>> that is being replayed after an upcall to mountd or the idmapper?
>>> It
>>> would mean that the synchronous wait in cache_defer_req() failed,
>>> so it
>>> is going to be rare, but it could happen on a congested system.
>>>=20
>>> AFAICS, svc_defer() does _not_ save rqstp->rq_xprt_ctxt, so
>>> svc_deferred_recv() won't restore it either.
>>=20
>> True, but TCP and UDP both use rq_xprt_ctxt, so wouldn't we have
>> seen this problem before on a socket transport?
>=20
> TCP does not set rq_xprt_ctxt, and nobody really uses UDP these days.
>=20
>> I need to audit code to see if saving rq_xprt_ctxt in svc_defer()
>> is safe and reasonable to do. Maybe Bruce has a thought.
>=20
> It should be safe for the UDP case, AFAICS. I have no opinion as of yet
> about how safe it is to do with RDMA.

It's plausible that a deferred request could be replayed, but I don't
understand the deferral mechanism enough to know whether the rctxt
would be released before the deferred request could be handled. It
doesn't look like it would, but I could misunderstand something.

There's a longstanding testing gap here: None of my test workloads
appear to force a request deferral. I don't recall Bruce having
such a test either.

It would be nice if we had something that could force the use of the
deferral path, like a command line option for mountd that would cause
it to sleep for several seconds before responding to an upcall. It
might also be done with the kernel's fault injector.


--
Chuck Lever



