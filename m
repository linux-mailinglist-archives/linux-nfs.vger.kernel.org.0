Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4F4EDEA4
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiCaQWX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 12:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbiCaQWV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 12:22:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC15613E416
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 09:20:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VFirBU027068;
        Thu, 31 Mar 2022 16:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5FS1zNFEUepQw/XChKL2tJ7qmwmhjTmyknZiqNCNS2E=;
 b=g29+Lvt85byJrrZsWLFxBA9MFHf7AEFoIuNLW+SseB4sTEbo8i72VmRRYSuLnbCKQPt0
 vnxfEowS+rd1uCIE7Mnm9pCDoyDLyoObmgyFmp86KKugZgGhlC9JoaOs84He3Wn/ZVcH
 T7a/K8KLualvFUAI2rRLvjhQUme3fVJl+AqgKu6WXInqOrPFTZvDO5yGtCO0w5w2EOt1
 ORYda6Ruz5FIRiZa2mRethAetRqRjZFzP+jm9Umi8xPLicOkd3plppXEN2ZXXYDusWcK
 hGr1lVYdL7m5dJHT5NSOFVEPjOL+/Dfvs2MDHM+mGElYv6SNzyh/1vScT1lmcsgAhlk4 AQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cvh75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:20:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VGFP8B019281;
        Thu, 31 Mar 2022 16:20:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95jnsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:20:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liPadfmZ1f85XGe2YVKTqLB72sRZiS+cHaX29h6p6zNfC3j7FsyZ8wc4AbZxbCEKUX1jZD3r+5YoOmfa7bErDYwPfOvHsyAZMmYwLfkPlihfSYB4u2OCPskaU37ksI5fyfmSkJ8CFkhJXKQG8gHK+kWd0z4F5tw6MhJi+PWfX+4vvMoVt/dw6g6hDhUrBWmXU0mYyNTDlTUTozLEV8l2KxyBhAbXHuQrYGsdOewSFPkLWVAOuBgr2o+Jt8muTCid+vQarUnwS3HuCjCNmU5yPAyQPUoYj0ymuUucLemQJlmvhRYeQcjF0O+zIuwOEPXakvgbElMEHJSZprVgZXMHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FS1zNFEUepQw/XChKL2tJ7qmwmhjTmyknZiqNCNS2E=;
 b=F5uXdCunhZGKak5csOouZkiphychbxpIweLlbiqZDapHEu5aI/sCnkZ3M3wyR6VwVCM63VOzjiPzre+JXpCAZgK/IkH9jy0+xNOaDqHa6ECrWAbyr3cnxy4DQnE3aHzWrizCc3y3Hj7RC6m15jlCIFFmWeqgbyvtrsC6paaWlTRtgeIMLRUWX/TdTnu7upDvw/Ztlk4+n8fGwmMmdrBMHMuzNytrhEoFMNIr27XGiskCKs9ZG+EWxWl59LljBUpXT9utlb3sqAIK2TCY5qjcLMoaY5xQKZ0WrgstmHPMO6Vv8dEi33CAZiHdAly03Jy6w1dMHVxpv/HXusRUGUsJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FS1zNFEUepQw/XChKL2tJ7qmwmhjTmyknZiqNCNS2E=;
 b=Mv/lArTq1dTZ4+KC3f7gQOxRIwevC24ndeap0zxa0gUj4htjN2MECEqzUKg7Xwvkxru2s7Luvi5Ko0jUczY3qpEblsNjfUOIsSbX8foAsOgP4GtI8MZM8wRssky0oZjaVLgwrxCCrfI7SlP8/7I8v5FyoDM3gaGJwCMlWd1O/CU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4352.namprd10.prod.outlook.com (2603:10b6:208:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 16:20:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 16:20:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Question about RDMA server...
Thread-Topic: Question about RDMA server...
Thread-Index: AQHYRRJNBcdkabgaO0Catodzu/oRE6zZm94AgAAKfQCAAARwgIAAAYeA
Date:   Thu, 31 Mar 2022 16:20:28 +0000
Message-ID: <2E4807E4-5086-4F15-B790-8D952B394FE5@oracle.com>
References: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>
 <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>
 <5DCBD9EB-7721-48FC-9EBD-58B7DF05A704@oracle.com>
 <8af942181abb39cd7ce8fe91be9c4c2f8c9f2c56.camel@hammerspace.com>
In-Reply-To: <8af942181abb39cd7ce8fe91be9c4c2f8c9f2c56.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb428fe3-41ad-4687-040c-08da13325e94
x-ms-traffictypediagnostic: MN2PR10MB4352:EE_
x-microsoft-antispam-prvs: <MN2PR10MB43523166B9521EFFCAF37E6193E19@MN2PR10MB4352.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzJeZJ2o9PUAqtV9g3ZhTk05g1GUN4BWH+rcqAz3wnoLnlQts3K4fSEl7SxsCdDhTKAzOBcHDIMqu5ocKWYVT0GsQn0ELiZDER5JlQwwUbB9jIUb9DfeAE96L6yOfh/U8FbQ+Sooaf9oVM35Z1mVhFmuXDNjrXl+S2ioqeFIlyy7vHegBO7DRVB8oPBFWM3TqZzSR3U32NffJWnKLg+GsYQ3sUC2+h71Hmj1yTJJOdjX/mYKZcLqi4GSmCTSUWWWFqhfEc8hnJGXlhh9JVwwb3j9FFvJgmFgeegflCDKoAsKwX6gHltWDhMBgKnNYessJxMWau5wwXWYWuGPiHLT0nrVKAJDYg+sRW11Lx1UEfKCl47KRMELuRlWcHdP2HzeRvYWl1sn7le/W7pj0I754jyBJY5dTgGMP9bwqLiXOpTMG8u5ZJ/l/rS429zxoa+YDNRUASNT/6L43oFeuzHHVTAxozaUNEGE9kqt0nXxnLkUvDl051v9AmIS3cRzJ37Iu1vh4jrsvUGa0+nRsrUYLLiyU7krRPuW9w4Dz8pLfff+jjJAc2gNk/c3eM5eaLe2fXhOkEpHpqUefjVemJmYO/s3DlwNO1D1o/OmEiS8fvqc49/e99P6I1Kl06h8iljYcId2vYzOM8VSGESAG3fZgMSgvrk2EZCfykOc060CYC1gj4BxjH3ESIdf4xL7qne/8RzUtB8wSQ5he5CxwZ9GTxT7zh4yQVKU7P6YXRZ1pho9i6e3L7VHvHLkX+rqH8Hr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(38100700002)(2906002)(6512007)(2616005)(38070700005)(508600001)(26005)(186003)(66556008)(316002)(6486002)(53546011)(6916009)(66446008)(66476007)(45080400002)(33656002)(64756008)(71200400001)(91956017)(83380400001)(76116006)(3480700007)(122000001)(86362001)(8936002)(36756003)(8676002)(4326008)(5660300002)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YWookDc8i700+/J2dlogPigBFFoKSu6+VZnxR3gNw1QIDIUOeKOVel7BH2FD?=
 =?us-ascii?Q?VTZoqxS/WwaiW+BBpxkZNFaWs+hdjFP2jua58DLqME4J+bQqYh2fqhOhHkTY?=
 =?us-ascii?Q?Ce3tVTTPBSbzV1DgWzxD5Km0i87BCF/RYI37MltjD4FR+Xxfnxi/naW37Nis?=
 =?us-ascii?Q?a+MyyX9VObWr9W/L1PT5bWJRL86P6fWF/4UwF7QS7Leq6a6ilX7w2BdcXfno?=
 =?us-ascii?Q?UQWI63vKFntU3hv1ByXh3RfJdlwgJI7LS3tOUGVTg5pAOiDdjD9hnuv125PK?=
 =?us-ascii?Q?ANhQyxLW7k+DUa3gCoq5qxSOnSJQc2QwGkpoddpuoW24kWOHYVVRQ89BzsTw?=
 =?us-ascii?Q?yqptYkd/tOm9DzICQl+RqgDPq1aDQvbBHW1y8N/jRrj4AUwVeu349Em7nM33?=
 =?us-ascii?Q?X3YGcOnLzf/9K0DpEaoXmxLpONB/L1THaZfZOKe8NP8yoJXy780BpwvaFWNA?=
 =?us-ascii?Q?cLaaUtpK9E0j87I22AV4GIxxxXdASTyWdpHhgPX+ARClZWf9OavRyvnu1J7Q?=
 =?us-ascii?Q?Rn78LNzJm0zTwxpOobDnwl0D9z4D5R3IDgVeb4X+bQRPIt7Vo9o9FcTEkMWk?=
 =?us-ascii?Q?cWB1/yfIqmxUi/JZSsvM18mASQkTuJtkWR6w2xjzQAyrAqKW33DH96R+RHUr?=
 =?us-ascii?Q?0ONj1HuQdXW1VxXU5WOzrJSgOYDGSe4qLkWj9eZ32Y7Jk8dZFi7pcRhtHyXB?=
 =?us-ascii?Q?Xq1bvS0AWUisMxpz3Z8jX3zM2R0SU3r32JmRghHQGe4amvdzTyq6o1ae6TcN?=
 =?us-ascii?Q?heBk0BFh+8OE3TicsDEbiMe0hPIqIBDLrqgL5NjstQohOovdOHLu58++FWcU?=
 =?us-ascii?Q?Ezc+dSvLIjWOgcmK90AYZOMQtZq9LgL+oU3oTlG4ZACdvfsIoZ3eUgtAcaHG?=
 =?us-ascii?Q?+6RSy0HmhD9R2F5ZnIiUFOChdsubhQW9+g+GH9URrGmoZcjEgIBEwyr91lgr?=
 =?us-ascii?Q?JVcyR2ppEFMiYfQWNx3PhUv919NvxIJs4eQbHtKveET3mOvinOdameJ1ADw9?=
 =?us-ascii?Q?zoo3qSm+W1qf+y/MdB7icP7Qu5VsIbirubA1V1tSobMd3jiybpOWk5ojQEBW?=
 =?us-ascii?Q?djpkXu0TVraq0kGHAq3VW4tQhFPcqOCt9rF10QbRLxdUzOvCaKlCcDR5qah3?=
 =?us-ascii?Q?TlHnaWtUT39edN82MNghyAUsmsdmUtrfP1o6XdjpGQxvhJvIqpeSMszGawmq?=
 =?us-ascii?Q?U4rv6pmKYWVrHWE8q7rhob3d5eIUpwlnGLYULuP5kVQhZtd7DJk+Uu2ea/tx?=
 =?us-ascii?Q?PTyy4PTZQQnDt05/Db0yLOTKciGK7aqFXiXCYUY5TemWL1tEcxU2zjRSFLPA?=
 =?us-ascii?Q?bXJEsC5Ju38iQLXguhwWg7kxEUGE2uRdo8p/rO4OjbJLZ4QU93uY6Jy8SMnZ?=
 =?us-ascii?Q?TTydtpnyFMF2vfS4LY2E5rzA/1dmQZPmEMjw6HWDeBtsl3rEMed1NGTkW3Yw?=
 =?us-ascii?Q?5BBDZAdN2DWslXoCOKhqTZOiexUFu3WW8L5d9NFO/h+EiVch1fy2DRube3KG?=
 =?us-ascii?Q?RuU/evhaKqPYH+UM1rYDzHeurdTI4JFAK0DrYvuXVZfCWyg1ncIy/B1z5ih1?=
 =?us-ascii?Q?RRzwrKPCp9yExwLy3Oh6Atz6cAEw1dFwJTYyZT1rh1Bae8hrvUSnJkPhcqSW?=
 =?us-ascii?Q?BbBICFMyIQOEzuWqq5A7Zcua55mN25lVfYfhJN/Pcs8/cBF9yrLOc0s7YGA/?=
 =?us-ascii?Q?d6xycYRZcFrpGWN+DzOXRs7ndAxxBgoyOiAloVLmhsvmeqSrKB3z8RunsIsx?=
 =?us-ascii?Q?+8sntFGQs7Qa2MpeVKlzH4F1GCpCj0k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D44BE1A00E3C594DA6DDB2369397E6F1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb428fe3-41ad-4687-040c-08da13325e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 16:20:28.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bd1GJZbv4zCFW2RDD4zZcRJYY3yln7WXCmX+cLIEKcpYXrkMzD5DcnDkK/eAXe/tvaWI7nv6dIrTV7Tux5dKQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4352
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310090
X-Proofpoint-GUID: YVwsafmGGaMLSkHU-irgICtJvd4JrywQ
X-Proofpoint-ORIG-GUID: YVwsafmGGaMLSkHU-irgICtJvd4JrywQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 31, 2022, at 12:15 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Thu, 2022-03-31 at 15:59 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Mar 31, 2022, at 11:21 AM, Chuck Lever III
>>> <chuck.lever@oracle.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Mar 31, 2022, at 11:16 AM, Trond Myklebust
>>>> <trondmy@hammerspace.com> wrote:
>>>>=20
>>>> Hi Chuck,
>>>>=20
>>>>=20
>>>> I'm seeing a very weird stack trace on one of our systems:
>>>>=20
>>>> [88463.974603] BUG: kernel NULL pointer dereference, address:
>>>> 0000000000000058
>>>> [88463.974778] #PF: supervisor read access in kernel mode
>>>> [88463.974916] #PF: error_code(0x0000) - not-present page
>>>> [88463.975037] PGD 0 P4D 0
>>>> [88463.975164] Oops: 0000 [#1] SMP NOPTI
>>>> [88463.975296] CPU: 4 PID: 12597 Comm: nfsd Kdump: loaded Not
>>>> tainted 5.15.31-200.pd.17802.el7.x86_64 #1
>>>> [88463.975452] Hardware name: VMware, Inc. VMware Virtual
>>>> Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
>>>> [88463.975630] RIP: 0010:svc_rdma_sendto+0x26/0x330 [rpcrdma]
>>>> [88463.975831] Code: 1f 44 00 00 0f 1f 44 00 00 41 57 41 56 41 55
>>>> 41 54 55 53 48 83 ec 28 4c 8b 6f 20 4c 8b a7 90 01 00 00 48 89 3c
>>>> 24 49 8b 45 38 <49> 8b 5c 24 58 a8 40 0f 85 f8 01 00 00 49 8b 45
>>>> 38 a8 04 0f 85 ec
>>>> [88463.976247] RSP: 0018:ffffad54c20b3e80 EFLAGS: 00010282
>>>> [88463.976469] RAX: 0000000000004119 RBX: ffff94557ccd8400 RCX:
>>>> ffff9455daf0c000
>>>> [88463.976705] RDX: ffff9455daf0c000 RSI: ffff9455da8601a8 RDI:
>>>> ffff9455da860000
>>>> [88463.976946] RBP: ffff9455da860000 R08: ffff945586b6b388 R09:
>>>> ffff945586b6b388
>>>> [88463.977196] R10: 7f0f1dac00000002 R11: 0000000000000000 R12:
>>>> 0000000000000000
>>>> [88463.977449] R13: ffff945663080800 R14: ffff9455da860000 R15:
>>>> ffff9455dabb8000
>>>> [88463.977709] FS:  0000000000000000(0000)
>>>> GS:ffff94586fd00000(0000) knlGS:0000000000000000
>>>> [88463.977982] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [88463.978254] CR2: 0000000000000058 CR3: 00000001f9282006 CR4:
>>>> 00000000003706e0
>>>> [88463.978583] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>> 0000000000000000
>>>> [88463.978865] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>> 0000000000000400
>>>> [88463.979141] Call Trace:
>>>> [88463.979419]  <TASK>
>>>> [88463.979693]  ? svc_process_common+0xfa/0x6a0 [sunrpc]
>>>> [88463.980021]  ? svc_rdma_cma_handler+0x30/0x30 [rpcrdma]
>>>> [88463.980320]  ? svc_recv+0x48a/0x8c0 [sunrpc]
>>>> [88463.980662]  svc_send+0x49/0x120 [sunrpc]
>>>> [88463.981009]  nfsd+0xe8/0x140 [nfsd]
>>>> [88463.981346]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
>>>> [88463.981675]  kthread+0x127/0x150
>>>> [88463.981981]  ? set_kthread_struct+0x40/0x40
>>>> [88463.982284]  ret_from_fork+0x22/0x30
>>>> [88463.982586]  </TASK>
>>>> [88463.982886] Modules linked in: nfsv3 bpf_preload xt_nat veth
>>>> nfs_layout_flexfiles auth_name rpcsec_gss_krb5 nfsv4 dns_resolver
>>>> nfsidmap nfs nfsd auth_rpcgss nfs_acl lockd grace xt_MASQUERADE
>>>> nf_conntrack_netlink xt_addrtype br_netfilter bridge stp llc
>>>> overlay nf_nat_ftp nf_conntrack_netbios_ns nf_conntrack_broadcast
>>>> nf_conntrack_ftp xt_CT xt_sctp ip6t_rpfilter ip6t_REJECT
>>>> nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack
>>>> ip6table_nat ip6table_mangle ip6table_security ip6table_raw
>>>> iptable_nat nf_nat iptable_mangle iptable_security iptable_raw
>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink
>>>> ip6table_filter ip6_tables iptable_filter vsock_loopback
>>>> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock
>>>> bonding ipmi_msghandler vfat fat rpcrdma sunrpc rdma_ucm ib_iser
>>>> libiscsi scsi_transport_iscsi ib_umad rdma_cm iw_cm ib_ipoib
>>>> ib_cm intel_rapl_msr intel_rapl_common crct10dif_pclmul mlx5_ib
>>>> crc32_pclmul ghash_clmulni_intel rapl ib_uverbs ib_core vmw_vmci
>>>> i2c_piix4
>>>> [88463.982930]  dm_multipath ip_tables xfs mlx5_core crc32c_intel
>>>> ttm vmxnet3 vmw_pvscsi drm_kms_helper mlxfw cec pci_hyperv_intf
>>>> tls ata_generic drm pata_acpi psample
>>>>=20
>>>> Decoding the address svc_rdma_sendto+0x26 resolves to line 927 in
>>>> net/sunrpc/xprtrdma/svc_rdma_sendto.c
>>>>=20
>>>> i.e.
>>>>=20
>>>> 927             __be32 *rdma_argp =3D rctxt->rc_recv_buf;
>>>>=20
>>>> which shows that somehow, we're getting to svc_rdma_sendto() with
>>>> a
>>>> request that has rqstp->rq_xprt_ctxt =3D=3D NULL.
>>>>=20
>>>> I'm having trouble seeing how that can happen, but thought I'd
>>>> ask in
>>>> case you've seen something similar. AFAICS, the code in that area
>>>> has
>>>> not changed since early 2021.
>>>>=20
>>>> As I understand it, knfsd was in the process of shutting down at
>>>> the
>>>> time, so it is possible there is a connection to that...
>>>=20
>>> My immediate response is "that's not supposed to happen". I'll give
>>> it some thought, but yeah, I bet the transport sendto code is not
>>> dealing with connection shutdown properly.
>>=20
>> I still don't see exactly how @rctxt could be NULL here, but
>> it might be enough to move the deref of @rctxt down past the
>> svc_xprt_is_dead() test, say just before "*p++ =3D *rdma_argp;".
>>=20
>> In any event, it could be that recent reorganization of generic
>> transport code might be responsible, or maybe that this is just
>> a hard race to hit.
>>=20
>=20
> Hmm... Here's another thought. What if this were a deferred request
> that is being replayed after an upcall to mountd or the idmapper? It
> would mean that the synchronous wait in cache_defer_req() failed, so it
> is going to be rare, but it could happen on a congested system.
>=20
> AFAICS, svc_defer() does _not_ save rqstp->rq_xprt_ctxt, so
> svc_deferred_recv() won't restore it either.

True, but TCP and UDP both use rq_xprt_ctxt, so wouldn't we have
seen this problem before on a socket transport?

I need to audit code to see if saving rq_xprt_ctxt in svc_defer()
is safe and reasonable to do. Maybe Bruce has a thought.


--
Chuck Lever



