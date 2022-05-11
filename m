Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5988D523CEF
	for <lists+linux-nfs@lfdr.de>; Wed, 11 May 2022 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345196AbiEKS5g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 May 2022 14:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbiEKS5e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 May 2022 14:57:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BAB46B1D
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 11:57:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BHgScs011683;
        Wed, 11 May 2022 18:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AXU5VUKI/lx3hVxi5fQxncXn3d3zAnZm9xC2wLjH9GQ=;
 b=RNKGYfLT63CwJaF/hoVZRzVMpdm7f5QsUbWpn3VB8qimRJ5lXYjG9jAAYLp1NCMmNBEp
 0KdUpVdWxNkArRsXqcoSQ2HIvRHJ0GGwL+lsLov6/3kMRD3E05iVJyoWkVItzj9FuglG
 4Nj6WREeFug5tbzGhTJ69d9b801mWmNjD+QtxEcrNjiMfRGc12gHUni/d4ee1y49vV4m
 ZN6O9/J9pc98j/f4aLA4sy3nthTxPDlRjr+B9x1nGyMWQYmF7s4L2dL0u09Q+xJ+T0Re
 jUjpIq7tbJDU3+6y/03vbNB2INM0svhTbhSTyvGGr/Z5YW9E/eHaZSiGn9BlaEgejKSE FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsttt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 18:57:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BIoRg1017918;
        Wed, 11 May 2022 18:57:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf74ekwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 18:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niqIxvSaUv74qjf0hho6seFTFPrnMn9V4kJjWyz6g4q/YhdbBP1V9a8lh7wPra1uGQXnivihEJ1IXiiziqoyZrPD1AKjU7wDl/RLR0015sJw/ZEG+/RFnMj8ouva/VcudUKd+aqUKbn2OLk1uo2bUTEKCrLcjsNbt/m39glfjstx6uGfnTOvo+XtwTT1H79zrL6P3yPuQYpBdYwj/TCCsTXgFoRGeEtCwkYEeGrLZVk1Ga9QkzXhfPRqdwXCKq/czaXPwyKr3+9phEmZw5VGDdtHbJsqMdyCsluF9IVn/AdFtKUw8MpmuL1f4N1pXwSOWo4VpCWzC+QZX1/Ri0hxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXU5VUKI/lx3hVxi5fQxncXn3d3zAnZm9xC2wLjH9GQ=;
 b=U3+KFjPndI6yaEOG6dJkr67v+9mJACoG3T5jXbHi3DfHHkieA/lZVm8L196+PKWMZPwpY/B5lqUOsVjOtlszPAA12+Qx8Ve1ftjtM73aSzJJw4uCvwjxBS+MbW7RUWHUj5j2tEzc5yMSikjUutGR1CDtcgNHsDrle0kJDoOtibE35t0/PwyPyicnDC60s3q0ThbJ/3sslAdvwxzWIYDrYF7BOF6Ftdyg4AXTnB2iXsMDxQnP07n8rRgw16lyLefXQ7M2ZT1oPR1jG+iBKbQoYCIqYI91AOfobM4rmF836HMzFitTLHTcZ0Gn1ttRdih/ZSGNtsvV4HJgC6fVRs7qDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXU5VUKI/lx3hVxi5fQxncXn3d3zAnZm9xC2wLjH9GQ=;
 b=uvKO+tUKgUdXIzlNDHRnLbFf3I7Nk+aWssS0aabFI+O7RNMnRfoOPg6STvYYflMAjGEPo9pbRCAfdU4ON8ut9668eSBx2OgN/CWiKhIM8Fn2aoE6fJ5szEDG2Tra+GkdV1v+KvnMRJGJeUC4PpojshwVL1PKp+aW4WA/vfwVXxs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 18:57:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 18:57:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Topic: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Index: AQHYXyGPzdf4A6mimkmk/DpMpv4nPq0YNS4AgAGbVYCAABRRAIAABPOAgAAR1ICAABgJgA==
Date:   Wed, 11 May 2022 18:57:26 +0000
Message-ID: <FF3D1FC6-12FB-4FAE-B9B9-08AC85437F96@oracle.com>
References: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
 <ED29F5B7-9839-4BCB-AE97-AAF776D95B28@oracle.com>
 <2BC5058C-FFEE-4741-9E51-4CC66E7F6306@oracle.com>
 <6942e1963dd3548cb9ba5d8586bd3913beb1ad45.camel@hammerspace.com>
 <342BDD54-5EF0-47BC-8691-E89148B085C1@oracle.com>
 <86cfd1a8afb0a8f68d9bba95c21f04090ebba461.camel@hammerspace.com>
In-Reply-To: <86cfd1a8afb0a8f68d9bba95c21f04090ebba461.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d7cf61e-9eed-4352-9a3d-08da3380170d
x-ms-traffictypediagnostic: CH2PR10MB4294:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4294A5D1EB8ADD5C2311377893C89@CH2PR10MB4294.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1XPYph4gI8lZnenlN9uN8ztnq0rDdsJ8qKMJo3cRoDFCuSqXkACEu7WE2U6Xa8PBLDAlqdZ1XATG4mZdcgZ1MUdDsIoYjhAduMegfJbX0GrCvqQ9repp9+Hc0+WR8J6jdptcTasmp0pigFwT6qSNafvCRMU2rdVeGCcMyr+jv/53XSun9rIG28Gn9n2w4BOLsB5M+g5x2ZVwxMFrZKgOTlojHdAchlq82sjBLv+ZERWlOQP+yk7roXrR43yUJtQEDxXHchgZROdjIuYCJEEOjjOiMYzjjhIBIvQ0igfm7xUP15LuDEPBQn/7/IZpGkehuMtCGtR6QyeFIrRrcUZ2c9wNm2VRvC6upqB/+6hCUtxd7viKOJ8IFLmPAT/JbIxPZaSUjedZ8o+8vNrV0U3SN+ea3/nQPu6lOfS4YlDNNkJ9XEFL4gUYTn+VOfoEDjVjP0UvWF6bOivCcC2LJ927WXj/xg0n3XMIESAzAXk1/YblPg1gboAxnla2zPBZWk35NV+1mamwbbqR4z9d49puWZZu7HG2qRf0EpufTS6rJ1iSjqku+3Z6bLBVjtwzkP8EfFjzcnpxKVkvQjkEc4SZfRKx2ouPW/mSX2hQvfWIufrROoYNGbqSht3kk9Ar9ywYxjtAy1vBsHVOtZsrWWNxFUPcaeIS7Jz818AYI2WVSrBGQAllX9yQ3MGgNrAmNmxpDPpEeqoxFYXYzJ7uO1bS9aRISTtMBoOcT8COVTl05Brjtwgts3xTNtOlm7vu67gv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6916009)(6512007)(71200400001)(4326008)(2616005)(26005)(91956017)(76116006)(6506007)(53546011)(8676002)(45080400002)(6486002)(316002)(508600001)(107886003)(54906003)(38100700002)(38070700005)(122000001)(186003)(5660300002)(83380400001)(30864003)(33656002)(8936002)(36756003)(2906002)(64756008)(66556008)(66946007)(66446008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sRNxMApCXOJq68H41Lnf+1578gxKiNd7U+0qaeWypOJOqMaVoNFIy8gdhdeu?=
 =?us-ascii?Q?K1gNEGC+6xNMlcdxLTNx/P9Uhr8pGX8UOC66WNMoEX3yoTt9+JsEOsPv93+J?=
 =?us-ascii?Q?A5tOj8SNFUT46qd0gZp5OxGGKRLMN7Ctuqg7Sdi/gKpmWR8kaV337yB1eQu9?=
 =?us-ascii?Q?jof6dsbIUeCa/+UhWzpUzCcK2iuk1DW2gCb5YN+PXzHFRfa3q8HNc2ApVlhp?=
 =?us-ascii?Q?9FsSKZtvansV3cVEpv4IZnYrh8X3UPHZD+pOsoH8zPXrSrrezg09MLvIaCqy?=
 =?us-ascii?Q?EgnkJLAti1pwfHFaEP0IlCykOS4sIF3tj0XngReGhBQpaJsAQjbzwqWPujID?=
 =?us-ascii?Q?7WB9U3+9vZLRMSnPvnvvT930OwHEX8B2+5PjcFPJuxrhkF+pVx96pxnVd2ie?=
 =?us-ascii?Q?AQQIvd+4PH6Gibc2LDqPx2iFy2KmcKFPbr/Jh5wMlGWQkdxbQa4Yf/De4hLe?=
 =?us-ascii?Q?Vf/1eEP+WOEX4hnT0T7szLeRZIC1rUkxRjuw1Vg4VofD7UNIHUCMiIqj+T1m?=
 =?us-ascii?Q?arOYLEuc4tP5puWu9fCR7H/869o2WUKSKs2tJj5jllml5o581xfHi+2/uGBY?=
 =?us-ascii?Q?uu9jo6JlibNxzgOeI93I4heyiaPnZ83gbvo477Ey0bsEHQU3P95Cn1Ybe6Qs?=
 =?us-ascii?Q?B0e+mOWPHlhx9J+todbs6ebmf4qQit0EEODX/l6lc+29k92iAjLM7X5hq2Vu?=
 =?us-ascii?Q?0nORgsDHS9cbfOIMAWWV5jtL6orhZA1hSsLWMziWfgnFQ1LDLCiBQ9RAd1TX?=
 =?us-ascii?Q?bu5SokJniECfFZx+obkm13LVAhd54pDAFQ1YmApkUKpSt4H8Jt2xWlqLS2Af?=
 =?us-ascii?Q?m5BebP9FFI4IU2Lj89mr1mGimbGIeLGShT2EUkKDZ7FI/wHJmVJGfCLJd18B?=
 =?us-ascii?Q?2JIT4NsTUy5C0Cm8vGfl2hES9q6wwSTqzQ4xWRH1vQDRI3oli6OtTg1eVRmJ?=
 =?us-ascii?Q?7hDXg9ARm5CBd7hvX1nx0eTwCWN9ja4lexerzHEGjmeVn+BrlsvQXgzflSgf?=
 =?us-ascii?Q?Y5glY0OFzYkJh6nTG6v6PLFYiW/AUtIC0Lyn8jiGBzwg+5j+qepyQmOaK7d5?=
 =?us-ascii?Q?k5QWHyoSVOY6iGcW01HfVWPqXH4rbsc5gwkerX+WmoF4i3+G0aKhSSflA/sR?=
 =?us-ascii?Q?V6o7MPg/uxXEaWxio6TBFs7inB1fWp5P0fyTwlY9IkeP5DS3V8Bb4pKPOabW?=
 =?us-ascii?Q?wAWiQCTvwi7Ck7s1a8P6VQ5kXS/MEwkKjoRCUyw4zvs1GXVaK4tdPYLuSqPX?=
 =?us-ascii?Q?kYQxeW2P3amIbYtiC3ag0HE2m5ye6QM+C6QVlDGvukVQyIHZZ4+9up7LVswt?=
 =?us-ascii?Q?TG/RN7Gggz+Ijbmaczpc69rsisiub29omDQe5VN4vJOVJB5RjJba9R59epY0?=
 =?us-ascii?Q?tFi+iy6P30jKcRHN2WgRYXV+CrRcnH0lmBgq1lsS5u/Ekw8dR47mNrZYC5CW?=
 =?us-ascii?Q?vnnASxWWnSPBmoIxZiGCMtCSXdAzHeI42WIGy/aVVqgm3L1ZRNDjIvdDcM3Z?=
 =?us-ascii?Q?zOAlrr2nED4xP8gmKBzVAjuoOJC1CM3Gbgz4x7fbRHGuRSLKyrtMhLALy9lS?=
 =?us-ascii?Q?hf4lqGYA8nS8+pPqJCUpOvq/tBwllA/GNaBnMD4HyEQuO9yV2onjGxWmB0Sr?=
 =?us-ascii?Q?W5RK8uQUOggkC5tTgV6VQWLuKSn3CsWAItXcRrqfQ8BerIJazuOkrWy6H4uc?=
 =?us-ascii?Q?+oC/FHJAK0f0JZbTNnnzGtCVhilF1bLt7VTIztrBpqwz7O1QGeciPCs4z1BL?=
 =?us-ascii?Q?2UhkZboSfqMdN2QhsLJvrYQRi65rJrY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EC7FAA4E01553468FC29F7FC87E5F9F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7cf61e-9eed-4352-9a3d-08da3380170d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 18:57:26.1788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6pYi4JDGYLf8XQTsNImsJWpT/DvSbls/PRhqXqmvol0CJvs//nUY4jxkekkSXI+2JzLL5aWfZoPBmc3CgPLMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110082
X-Proofpoint-GUID: v_leULIMfydoO52qDOjQHxBZ9c0o9Pmh
X-Proofpoint-ORIG-GUID: v_leULIMfydoO52qDOjQHxBZ9c0o9Pmh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 11, 2022, at 1:31 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Wed, 2022-05-11 at 16:27 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On May 11, 2022, at 12:09 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Wed, 2022-05-11 at 14:57 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On May 10, 2022, at 10:24 AM, Chuck Lever III
>>>>> <chuck.lever@oracle.com> wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>> On May 3, 2022, at 3:11 PM, dai.ngo@oracle.com wrote:
>>>>>>=20
>>>>>> Hi,
>>>>>>=20
>>>>>> I just noticed there were couple of oops in my Oracle6 in
>>>>>> nfs4.dev network.
>>>>>> I'm not sure who ran which tests (be useful to know) that
>>>>>> caused
>>>>>> these oops.
>>>>>>=20
>>>>>> Here is the stack traces:
>>>>>>=20
>>>>>> [286123.154006] BUG: sleeping function called from invalid
>>>>>> context at kernel/locking/rwsem.c:1585
>>>>>> [286123.155126] in_atomic(): 1, irqs_disabled(): 0,
>>>>>> non_block: 0,
>>>>>> pid: 3983, name: nfsd
>>>>>> [286123.155872] preempt_count: 1, expected: 0
>>>>>> [286123.156443] RCU nest depth: 0, expected: 0
>>>>>> [286123.156771] 1 lock held by nfsd/3983:
>>>>>> [286123.156786]  #0: ffff888006762520 (&clp->cl_lock){+.+.}-
>>>>>> {2:2}, at: nfsd4_release_lockowner+0x306/0x850 [nfsd]
>>>>>> [286123.156949] Preemption disabled at:
>>>>>> [286123.156961] [<0000000000000000>] 0x0
>>>>>> [286123.157520] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Not
>>>>>> tainted 5.18.0-rc4+ #1
>>>>>> [286123.157539] Hardware name: innotek GmbH
>>>>>> VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>>>>> [286123.157552] Call Trace:
>>>>>> [286123.157565]  <TASK>
>>>>>> [286123.157581]  dump_stack_lvl+0x57/0x7d
>>>>>> [286123.157609]  __might_resched.cold+0x222/0x26b
>>>>>> [286123.157644]  down_read_nested+0x68/0x420
>>>>>> [286123.157671]  ? down_write_nested+0x130/0x130
>>>>>> [286123.157686]  ? rwlock_bug.part.0+0x90/0x90
>>>>>> [286123.157705]  ? rcu_read_lock_sched_held+0x81/0xb0
>>>>>> [286123.157749]  xfs_file_fsync+0x3b9/0x820
>>>>>> [286123.157776]  ? lock_downgrade+0x680/0x680
>>>>>> [286123.157798]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>>>>>> [286123.157823]  ? nfsd_file_put+0x100/0x100 [nfsd]
>>>>>> [286123.157921]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>>>> [286123.158007]  nfsd_file_put+0x79/0x100 [nfsd]
>>>>>> [286123.158088]  check_for_locks+0x152/0x200 [nfsd]
>>>>>> [286123.158191]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>>>>>> [286123.158393]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>>>>>> [286123.158488]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>> [286123.158525]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>>>>>> [286123.158699]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>>>>>> [286123.158974]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>> [286123.159010]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>>>>>> [286123.159043]  ? svc_generic_rpcbind_set+0x450/0x450
>>>>>> [sunrpc]
>>>>>> [286123.159043]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>>>>>> [286123.159043]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>>>>>> [286123.159043]  ? svc_recv+0x1100/0x2390 [sunrpc]
>>>>>> [286123.159043]  svc_process+0x361/0x4f0 [sunrpc]
>>>>>> [286123.159043]  nfsd+0x2d6/0x570 [nfsd]
>>>>>> [286123.159043]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>>>>>> [286123.159043]  kthread+0x29f/0x340
>>>>>> [286123.159043]  ? kthread_complete_and_exit+0x20/0x20
>>>>>> [286123.159043]  ret_from_fork+0x22/0x30
>>>>>> [286123.159043]  </TASK>
>>>>>> [286123.187052] BUG: scheduling while atomic:
>>>>>> nfsd/3983/0x00000002
>>>>>> [286123.187551] INFO: lockdep is turned off.
>>>>>> [286123.187918] Modules linked in: nfsd auth_rpcgss nfs_acl
>>>>>> lockd
>>>>>> grace sunrpc
>>>>>> [286123.188527] Preemption disabled at:
>>>>>> [286123.188535] [<0000000000000000>] 0x0
>>>>>> [286123.189255] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded
>>>>>> Tainted: G        W         5.18.0-rc4+ #1
>>>>>> [286123.190233] Hardware name: innotek GmbH
>>>>>> VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>>>>> [286123.190910] Call Trace:
>>>>>> [286123.190910]  <TASK>
>>>>>> [286123.190910]  dump_stack_lvl+0x57/0x7d
>>>>>> [286123.190910]  __schedule_bug.cold+0x133/0x143
>>>>>> [286123.190910]  __schedule+0x16c9/0x20a0
>>>>>> [286123.190910]  ? schedule_timeout+0x314/0x510
>>>>>> [286123.190910]  ? __sched_text_start+0x8/0x8
>>>>>> [286123.190910]  ? internal_add_timer+0xa4/0xe0
>>>>>> [286123.190910]  schedule+0xd7/0x1f0
>>>>>> [286123.190910]  schedule_timeout+0x319/0x510
>>>>>> [286123.190910]  ? rcu_read_lock_held_common+0xe/0xa0
>>>>>> [286123.190910]  ? usleep_range_state+0x150/0x150
>>>>>> [286123.190910]  ? lock_acquire+0x331/0x490
>>>>>> [286123.190910]  ? init_timer_on_stack_key+0x50/0x50
>>>>>> [286123.190910]  ? do_raw_spin_lock+0x116/0x260
>>>>>> [286123.190910]  ? rwlock_bug.part.0+0x90/0x90
>>>>>> [286123.190910]  io_schedule_timeout+0x26/0x80
>>>>>> [286123.190910]  wait_for_completion_io_timeout+0x16a/0x340
>>>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>> [286123.190910]  ? wait_for_completion+0x330/0x330
>>>>>> [286123.190910]  submit_bio_wait+0x135/0x1d0
>>>>>> [286123.190910]  ? submit_bio_wait_endio+0x40/0x40
>>>>>> [286123.190910]  ? xfs_iunlock+0xd5/0x300
>>>>>> [286123.190910]  ? bio_init+0x295/0x470
>>>>>> [286123.190910]  blkdev_issue_flush+0x69/0x80
>>>>>> [286123.190910]  ? blk_unregister_queue+0x1e0/0x1e0
>>>>>> [286123.190910]  ? bio_kmalloc+0x90/0x90
>>>>>> [286123.190910]  ? xfs_iunlock+0x1b4/0x300
>>>>>> [286123.190910]  xfs_file_fsync+0x354/0x820
>>>>>> [286123.190910]  ? lock_downgrade+0x680/0x680
>>>>>> [286123.190910]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
>>>>>> [286123.190910]  ? nfsd_file_put+0x100/0x100 [nfsd]
>>>>>> [286123.190910]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>>>> [286123.190910]  nfsd_file_put+0x79/0x100 [nfsd]
>>>>>> [286123.190910]  check_for_locks+0x152/0x200 [nfsd]
>>>>>> [286123.190910]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
>>>>>> [286123.190910]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
>>>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>> [286123.190910]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
>>>>>> [286123.190910]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
>>>>>> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
>>>>>> [286123.190910]  svc_process_common+0xd8e/0x1b20 [sunrpc]
>>>>>> [286123.190910]  ? svc_generic_rpcbind_set+0x450/0x450
>>>>>> [sunrpc]
>>>>>> [286123.190910]  ? nfsd_svc+0xc50/0xc50 [nfsd]
>>>>>> [286123.190910]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
>>>>>> [286123.190910]  ? svc_recv+0x1100/0x2390 [sunrpc]
>>>>>> [286123.190910]  svc_process+0x361/0x4f0 [sunrpc]
>>>>>> [286123.190910]  nfsd+0x2d6/0x570 [nfsd]
>>>>>> [286123.190910]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
>>>>>> [286123.190910]  kthread+0x29f/0x340
>>>>>> [286123.190910]  ? kthread_complete_and_exit+0x20/0x20
>>>>>> [286123.190910]  ret_from_fork+0x22/0x30
>>>>>> [286123.190910]  </TASK>
>>>>>>=20
>>>>>> The problem is the process tries to sleep while holding the
>>>>>> cl_lock by nfsd4_release_lockowner. I think the problem was
>>>>>> introduced with the filemap_flush in nfsd_file_put since
>>>>>> 'b6669305d35a nfsd: Reduce the number of calls to
>>>>>> nfsd_file_gc()'.
>>>>>> The filemap_flush is later replaced by nfsd_file_flush by
>>>>>> '6b8a94332ee4f nfsd: Fix a write performance regression'.
>>>>>=20
>>>>> That seems plausible, given the traces above.
>>>>>=20
>>>>> But it begs the question: why was a vfs_fsync() needed by
>>>>> RELEASE_LOCKOWNER in this case? I've tried to reproduce the
>>>>> problem, and even added a might_sleep() call in
>>>>> nfsd_file_flush()
>>>>> but haven't been able to reproduce.
>>>>=20
>>>> Trond, I'm assuming you switched to a synchronous flush here to
>>>> capture writeback errors. There's no other requirement for
>>>> waiting for the flush to complete, right?
>>>=20
>>> It's because the file is unhashed, so it is about to be closed and
>>> garbage collected as soon as the refcount goes to zero.
>>>=20
>>>>=20
>>>> To enable nfsd_file_put() to be invoked in atomic contexts again,
>>>> would the following be a reasonable short term fix:
>>>>=20
>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>> index 2c1b027774d4..96c8d07788f4 100644
>>>> --- a/fs/nfsd/filecache.c
>>>> +++ b/fs/nfsd/filecache.c
>>>> @@ -304,7 +304,7 @@ nfsd_file_put(struct nfsd_file *nf)
>>>>  {
>>>>         set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>>>         if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
>>>> -               nfsd_file_flush(nf);
>>>> +               filemap_flush(nf->nf_file->f_mapping);
>>>>                 nfsd_file_put_noref(nf);
>>>>         } else {
>>>>                 nfsd_file_put_noref(nf);
>>>>=20
>>>>=20
>>>=20
>>> filemap_flush() sleeps, and so does nfsd_file_put_noref() (it can
>>> call
>>> filp_close() + fput()), so this kind of change isn't going to work
>>> no
>>> matter how you massage it.
>>=20
>> Er. Wouldn't that mean we would have seen "sleep while spinlock is
>> held" BUGs since nfsd4_release_lockowner() was added? It's done
>> at least an fput() while holding clp->cl_lock since it was added,
>> I think.
>=20
>=20
> There is nothing magical about using WB_SYNC_NONE as far as the
> writeback code is concerned. write_cache_pages() will still happily
> call lock_page() and sleep on that lock if it is contended. The
> writepage/writepages code will happily try to allocate memory if
> necessary.
>=20
> The only difference is that it won't sleep waiting for the PG_writeback
> bit.
>=20
> So, no, you can't safely call filemap_flush() from a spin locked
> context, and
> yes, the bug has been there from day 1. It was not introduced by me.
>=20
> Also, as I said, nfsd_file_put_noref() is not safe to call from a spin
> locked context. Again, this was not introduced any time recently.

OK. I'm trying to figure out how bad the problem is and how
far back to apply the fix.

I agree that the arrangement of the code path means
nfsd4_release_lockowner() has always called fput() or
filemap_flush() while cl_lock was held.

But again, I'm not aware of recent instances of this particular
splat. So I'm wondering if a recent change has made this issue
easier to hit. We might not be able to answer that until we
find out how the bake-a-thon testers managed to trigger the
issue on Dai's server.


>>> Is there any reason why you need a reference to the nfs_file there?
>>> Wouldn't holding the fp->fi_lock be sufficient, since you're
>>> already in
>>> an atomic context? As long as one of the entries in fp->fi_fds[] is
>>> non-zero then you should be safe.
>>=20
>> Sure, check_for_locks() seems to be the only problematic caller.
>> Other callers appear to be careful to call nfsd_file_put() only
>> after releasing spinlocks.
>>=20
>> I would like a fix that can be backported without fuss. I was
>> thinking changing check_for_locks() might get a little too
>> hairy for that, but I'll check it out.

Notably: check_for_locks() needs to drop fi_lock before taking
flc_lock because the OPEN path can take flc_lock first, then
fi_lock, via nfsd_break_deleg_cb(). Holding a reference to the
nfsd_file guarantees that the inode won't go away while
check_for_locks() examines the flc_posix list without holding
fi_lock.

So my first take on this was we need nfsd4_release_lockowner()
to drop cl_lock before check_for_locks() is called.


--
Chuck Lever



