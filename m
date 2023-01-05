Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB12665EE2D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 15:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjAEODU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 09:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjAEOC7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 09:02:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB84D727
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 06:02:56 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305DpqHT016101;
        Thu, 5 Jan 2023 14:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=k4kZGWKcufZ43LuWFzblW/OmghfGsUAFtuNs2tVn1Lk=;
 b=DBmV7fu90+WFBda0Uk88fkTx0w1acotlSGja4PRhpOWhQ7WeaoE7xsZEqhbEbG6u/9WD
 GKw98kKivA5aab0pysJtA6paCzHdjvYUdhsyZXo7GENEgRm7141ACwu33OUn9IrdLp11
 hfPI2rXRqJhsfQlgnW5t/nHkprXKy5B35+1RxAvv0sNG0I2ekWv/2ktlFIZP0yc+BXh6
 ceG3bau/70T6+HMKq1CAoze0NFDjbTnNoT3FZHGr937nk1kvIEs6RRhMr3vg0Efau6Vn
 JmyP0l1fwLXQI6vuTk82/SFbphWCuViWNP3TDi0L190yYOYv3rETnKI1+s+0Bs8LhX/9 cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp10w1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:02:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305CvSso024189;
        Thu, 5 Jan 2023 14:02:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevjhq0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRzQUZYZh6jFW8eYqE22zvSEVVYL9TT6HiZh/VDbA4RGfohnN3UKRtaDjPwn01IDbAI9kXHA0hcHji1X8rb767oWYCJyIYFeHG6E/uJDhikCMBneR9kIJ5DnTy/DOPEPWy3JGtbmFgtSWWVODPPTcCTdjWJtbm9QxnUJ2ygFXPlwpXnoV+ZnTP5epemSF72EM/wjXs+NUIk4Ijcyhd4ZDGgvcnicz61HmDpWI+YCatioeKvHedqiA93uE5mRtVpjm4lzLbL4LvafC2rgPhgl14ky04r3o+CvjM+X9GhoO0s9ucShqra35cooMob+9DrAh+vhqL9voEKJXEG+Zm/6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4kZGWKcufZ43LuWFzblW/OmghfGsUAFtuNs2tVn1Lk=;
 b=XCffBAUWh3lZFFSv9mSBJf2fWMmDYFfZGLHIjreZTSO7Y4UOzhN+QZaQWkY242rab0aG2W53ICd9+XfFRzt78OSQ+3BFuIzKwghYfxAOPiKf8TGwM+FmAqeiMB/NJPL6/LmO1FNJ4+crCTVXywz7a4wRWR3uAY5pwBzJh3WFHcWVgssfiqL00lvUg181UzJHMigwnr6XNRMkuew2KLIyi5BSytsmlpzdSbSRxWu+ei5p2DsX9wS0VyeB1og23TWtGjYC+wXKPZhJA5K8U8it+uTpJklk7JEy5v5/pTOaPOKryRC7N2UHH0LdaXIjCDI6JzbPN2uH3oNaGuUrEmVJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4kZGWKcufZ43LuWFzblW/OmghfGsUAFtuNs2tVn1Lk=;
 b=deEIHA9ip8cwJZvpHtlNw5OTTDgnyfalGEsKKPPxQ8pyZ9ISCldV+inolOw2FmeMgHb5+fjXgo4lO7B123j5a7dgONw+r2PQubfKSBpChtt3l4ERhFMCNYz9NkahNaW+Dzou6Sakcvtu2bh5ta3mxtVT7a8UG1SA6u9dI7mlqwk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:02:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:02:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Stanislav Saner <ssaner@redhat.com>
Subject: Re: [PATCH v2] nfsd: fix handling of cached open files in nfsd4_open
 codepath
Thread-Topic: [PATCH v2] nfsd: fix handling of cached open files in nfsd4_open
 codepath
Thread-Index: AQHZIPghp2I3vD8/IkKK0oxcK2gg4q6P2siA
Date:   Thu, 5 Jan 2023 14:02:36 +0000
Message-ID: <EC37F3C6-6CBB-4FA0-8C22-45220D4732FC@oracle.com>
References: <20230105112318.14496-1-jlayton@kernel.org>
In-Reply-To: <20230105112318.14496-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4137:EE_
x-ms-office365-filtering-correlation-id: f80fed44-6f8e-4420-a9fe-08daef257fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SVdufDOLN3/ipd09cf2vmug5xyAOI6fCzmzwwU/M4FM03bnahzkJMfRY/b8Qc4VXi65Av0QiiosMMoWkzzlffYcY/b2Wlcdtjq4+MAzLDeacyVFV1iSXbEte987xj7u/MxeQy2EziTls0sh+L5fgqIZBzp6iiYFLScMpDx0GzEx4cb1/WxjUbBM3xxRhCHR3LOGz90jobdUqPsAudRtFfEfmPEyuSCmpp9sfRfUMh8QOt24pL+jAd57+9ZoGyzS88XHBsmVd1RzTjSxX+LoyGLw8cIi2abLVL8i/W/5yR277dCveAICtCDoya0REW/Jd8mpLPa9Ue1a+4gNO6EbGTN/BVsJ6cEx3KpPnXe0zTvpAcm+DPq656S0t7CqH7OWNEUd/jmaeJd2X94WIL2qenTGaJpsngf9wJ4nTz13e0uu4u3ujPSu3HvAYhpphiH5vFFm2eT/5IT3uaPUOIyIvW6xHPRoyQk+otNbs94OEGYeZwrzmhxIjV4+lyCnjYPwoE+fkHdEW9pii4UHs7m9/MWVVsvPA+rI8v2tYxCfv1vGUCFJcfrC3RL2ILUC4BWrm01V4aSWvC/4c6Y/QxEWFIIO/JsZH29hNxlfz8iNo4svc4+bZ6UjimeSqdFax8CXofyr6v5UgnWegkE09vK0tPEySC4jtDBcbcOW06x2/NUotzzwi+AmA7EVUDN2ydNcOZOqNicaTk8nm3nL+UYE9QDFFk3Pg6kxv15/OiEgFz9c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(33656002)(36756003)(38100700002)(2906002)(8936002)(122000001)(5660300002)(41300700001)(30864003)(83380400001)(38070700005)(86362001)(54906003)(66946007)(6916009)(6486002)(76116006)(66556008)(71200400001)(478600001)(91956017)(64756008)(66476007)(4326008)(6512007)(316002)(66446008)(26005)(53546011)(8676002)(186003)(6506007)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6uXbAOVyHIBNb946RiYmp99TF0Q3lxOVrOLHDMh9jNa/HyWXS/XR+i3hMWG0?=
 =?us-ascii?Q?q+aaSEWf/qOx6+9B8QecWeIlYr5nXD7RpArAut051Z1kdGHoEi+YrIDfNm79?=
 =?us-ascii?Q?+w3+2TqClATd3iCrtltYOgRtt2gKhdKhj5VmyrL5rLTCLS1CQBDj40AQ0yEz?=
 =?us-ascii?Q?cAi9JzvUFkoW9j5AVzZq5EjJmBmv/wiMIhJQ2MFPTm2Fnu3xcLHkPKGoz7nW?=
 =?us-ascii?Q?cSm3R+zZemb5tqAwdlwMDNcUSaU0nrsH7K7/gKIt1f6LWWisE/aSwQfAbpzP?=
 =?us-ascii?Q?PQTrBFJvsyvEDLh6rAPcI8u5XjzHRDpbuB2eRcnhVCC11ctRYuPQminWsCQW?=
 =?us-ascii?Q?y42EoMh5zxhSvTcqhPAqWH/sDd93AIib7k2A4LC53IXXB3rgfE9+1xEMh8Dc?=
 =?us-ascii?Q?pjyI3dyQuskdxcdXMuRu1mRnSqUczCDctLTUYlHJ1iwCkfPJ50O8TS3+EMew?=
 =?us-ascii?Q?pkCO57KyHbZiKFcLluWLIvym0KZBy9brXYkN5UuW1GxTNmT0d8wzW9dCtLJ1?=
 =?us-ascii?Q?5IVwMW5SeocZlwgq9rh8BXzj6HL7VdeIOqS3XzSGXZMT0Z3ILob/U6w03LUA?=
 =?us-ascii?Q?TtR0uZzs8/wrYe6jqVpZlPviSNIXEY84cBgZb/TaY1uIlNevGb+mSdlsp7U0?=
 =?us-ascii?Q?5bco5KJ0UaFyLHYGkTyiCp84OpOy45SsEct7NSIhW2I4It7EQlXJbCQzlUOu?=
 =?us-ascii?Q?NSHizQgeM3ZyxRhguD9ccS/CszVBLLxST539eACcrR6Wy1mZ635akWuakN73?=
 =?us-ascii?Q?kMEkWDryIyqntxNWB9lcHULu/VrMo3dRpEDzmD/J/hlP7bxPtIYVF7ehaKqj?=
 =?us-ascii?Q?jW74LT1Xn7ScYWXvmJN174UNffX/7oGyPuNh2yGtgGFMpRNAQO4CnJ/E5Ngt?=
 =?us-ascii?Q?rr56k7a9v+/KKlJhjeEcUqQFEJSaDD7RM6/VvMC7MZOTP0G8pWN1tUCAPuvW?=
 =?us-ascii?Q?AyNBHpgrUxpRs5a8mjzuJyBrdlHR+GvmTAdnrQKHzcnqmOMa+Qz2kk69REOm?=
 =?us-ascii?Q?X9rI+vGuWHBn8VyHTgdU9We2Oyw4nux0OROuuiAteixytR5wPK1MqepUyxqw?=
 =?us-ascii?Q?R43Qan3o99aDEJyptRpZ/DZcLve5JVhSWE1kr18fHXzEoVMiL5tBrdg9eWT/?=
 =?us-ascii?Q?HqDgkITzI4HukdlO/eOviEy4fMMhnAVXCFYdx5nxVo7IDV25ZsxiSgY+lxwY?=
 =?us-ascii?Q?GmCWgpJE4AWPJ+f5CtpwTU+LszvFaTRXrw9+Oh/Gj3KBPXhsHZqsBrFGrqr1?=
 =?us-ascii?Q?uGi123Ekw8xCNG3XNwb12YfRBfXSy5jz+3zZk21PtXxWz/CVB4FONFwqGsLB?=
 =?us-ascii?Q?3i1v6LNPjmlwLvb/IaU14WO6KkIQdQW5DAQTrAAgCYANXTKNFkb4xD/dXB1B?=
 =?us-ascii?Q?OEwq2Svkzi8ygq8MVFC3qix5oqp2W0V1pt8+6sV1N2G4elY7j1OJmPFxsxmJ?=
 =?us-ascii?Q?9LNg+65KiHhsIAvxC4vyXBZe68f2JmE0VpVwuD4cquKT87vO28sStOQYRRsf?=
 =?us-ascii?Q?+m/7Efs8tseOsVzo3kGsp/0Chj5V4tY9QnQEZgurcCsUo8G9o2IZnFcvWBzA?=
 =?us-ascii?Q?qyN9g0SVd2YhKp4RhNaC9RWetM3aiVyKa+8qWlNSdjChh2emRvRZU+5qGpGq?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2E9DE60FC44054794D1AB9C8B1E26E6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YJUbSXwofcO1gHoEBzTqNuH2n0V0RnTJ3CM7c/8pH4iH48EUKrRhnzTxyPmmyZOMdzGnzFKjgGcIHOIj/4mXq1iJqo5rv6PtVnl/tU0nq+Goe9szAvnOqjsPd+6HSR39NPf6BBzPnuh5YaLlKHUXxgPvu3p+rKtGiJzDKjitl1k/Vs1FNQ6sMcA/n24FycfdHwUC/1BEhHbkNyjiuEOjnZnm0cI7d9VIkcUnmFi5LiSCT9KiSkZTr0FoMVk8O2vKxYctHTA7hV9dYWV4Hvmb/RTPSMV0UzSNdUSQhnQGQwNN16nqFtok3G5kGXqvNJP7X0yYo+GW58DDfJatknkeG2jD8Ut2g+YlRsBroODWsGdsTduUq5i43zoJaJaPRc5SmW1ptRACdN9ElpSbzo2KONmVcgDZNT/TMID9OtKv/0ghe3JAL5CIJa6SRDhIbfkd8Nd5MZkkBdhSevL2FDeEQHrJ9rfBEADJYzlKBR3ijxzqoKJCiWLi/1kcbOPdT2Nm/MpsGIONQYhMWKDEcAONx19Qh5egQMggo3tZN/bbZ6F1mw513Lzh4Uvcazmk6d7TQDYUWbZCs/iuBiRUL1YWCe+r+O+J51yzPQjb1kTikGI+UrRhHQrW6hEflnrF4loHn0PpJH8lAk2+x58kk4yPpl8dIM6Qx+sJ74U/AjbHJDYFHIQssRGnK9pUIkJAhJ55bp5Z57fDWW3wvExe//tshKS/JHF5kKAl43S0/ewvfPyGXoJAzViBIj5pwTsZydhCfM1Tt24bWe9UGIaPs7kvbRckuc2zeq95nNbfClT2kcR9+gNBrkxwPQN8rOHwGiKNp8dYaCG83SqKusbYwqj5qBefDWAB318HHT1bkCWALZiCIZJ6kKGrSFXtuUm2SZ2ygRB/UCSYZ9bYgIukWVqxRSUQbEiURs32V1TfmoLGbmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80fed44-6f8e-4420-a9fe-08daef257fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 14:02:36.2941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMtAIEucdlKnhvk79pCgLkTQVvU7COvY9gCR6vqfHk8e4gkQ3OHn6zQqNNqR+e88ziIHebK4028eVuW5FPvOww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050110
X-Proofpoint-GUID: QRC-kvnaOSZsbJtbbcR2ZQyCY67KgrIn
X-Proofpoint-ORIG-GUID: QRC-kvnaOSZsbJtbbcR2ZQyCY67KgrIn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 5, 2023, at 6:23 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
> regular NFSv4 file") added the ability to cache an open fd over a
> compound. There are a couple of problems with the way this currently
> works:
>=20
> It's racy, as a newly-created nfsd_file can end up with its PENDING bit
> cleared while the nf is hashed, and the nf_file pointer is still zeroed
> out. Other tasks can find it in this state and they expect to see a
> valid nf_file, and can oops if nf_file is NULL.
>=20
> Also, there is no guarantee that we'll end up creating a new nfsd_file
> if one is already in the hash. If an extant entry is in the hash with a
> valid nf_file, nfs4_get_vfs_file will clobber its nf_file pointer with
> the value of op_file and the old nf_file will leak.
>=20
> Fix both issues by changing nfsd_file_acquire to take an optional file
> pointer. If one is present when this is called, we'll take a new
> reference to it instead of trying to open the file. If the nfsd_file
> already has a valid nf_file, we'll just ignore the optional file and
> pass the nfsd_file back as-is.
>=20
> Also rework the tracepoints a bit to allow for a cached open variant,
> and don't try to avoid counting acquisitions in the case where we
> already have a cached open file.
>=20
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Reported-by: Stanislav Saner <ssaner@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 49 ++++++++++++++----------------------------
> fs/nfsd/filecache.h |  5 ++---
> fs/nfsd/nfs4proc.c  |  2 +-
> fs/nfsd/nfs4state.c | 20 ++++++-----------
> fs/nfsd/trace.h     | 52 ++++++++++++---------------------------------
> 5 files changed, 38 insertions(+), 90 deletions(-)
>=20
> v2: rebased directly onto current master branch to fix up some
>    contextual conflicts

Hi Jeff-

The basic race is that nf_file must be filled in before the PENDING
bit is cleared. Got it.

Seems like -rc fodder, and needs a Fixes: tag.

However, I'd prefer to keep the synopses of nfsd_file_acquire() and
nfsd_file_acquire_gc() identical. nfs4_get_vfs_file() is the one
spot that needs this special behavior, so it should continue to
call nfsd_file_create(), or something like it. How about one of:

nfsd_file_acquire2
nfsd_file_acquire_create
nfsd_file_acquire_cached


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 45b2c9e3f636..6674a86e1917 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1071,8 +1071,8 @@ nfsd_file_is_cached(struct inode *inode)
>=20
> static __be32
> nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		     unsigned int may_flags, struct nfsd_file **pnf,
> -		     bool open, bool want_gc)
> +		     unsigned int may_flags, struct file *file,
> +		     struct nfsd_file **pnf, bool want_gc)
> {
> 	struct nfsd_file_lookup_key key =3D {
> 		.type	=3D NFSD_FILE_KEY_FULL,
> @@ -1147,8 +1147,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_f=
lags));
> out:
> 	if (status =3D=3D nfs_ok) {
> -		if (open)
> -			this_cpu_inc(nfsd_file_acquisitions);
> +		this_cpu_inc(nfsd_file_acquisitions);
> 		*pnf =3D nf;
> 	} else {
> 		if (refcount_dec_and_test(&nf->nf_ref))
> @@ -1158,20 +1157,23 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>=20
> out_status:
> 	put_cred(key.cred);
> -	if (open)
> -		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
> +	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
> 	return status;
>=20
> open_file:
> 	trace_nfsd_file_alloc(nf);
> 	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
> 	if (nf->nf_mark) {
> -		if (open) {
> +		if (file) {
> +			get_file(file);
> +			nf->nf_file =3D file;
> +			status =3D nfs_ok;
> +			trace_nfsd_file_open_cached(nf, status);
> +		} else {
> 			status =3D nfsd_open_verified(rqstp, fhp, may_flags,
> 						    &nf->nf_file);
> 			trace_nfsd_file_open(nf, status);
> -		} else
> -			status =3D nfs_ok;
> +		}
> 	} else
> 		status =3D nfserr_jukebox;
> 	/*
> @@ -1207,7 +1209,7 @@ __be32
> nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		     unsigned int may_flags, struct nfsd_file **pnf)
> {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, true);
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
> }
>=20
> /**
> @@ -1215,6 +1217,7 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  * @rqstp: the RPC transaction being executed
>  * @fhp: the NFS filehandle of the file to be opened
>  * @may_flags: NFSD_MAY_ settings for the file
> + * @file: cached, already-open file (may be NULL)
>  * @pnf: OUT: new or found "struct nfsd_file" object
>  *
>  * The nfsd_file_object returned by this API is reference-counted
> @@ -1226,30 +1229,10 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>  */
> __be32
> nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		  unsigned int may_flags, struct nfsd_file **pnf)
> -{
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, false);
> -}
> -
> -/**
> - * nfsd_file_create - Get a struct nfsd_file, do not open
> - * @rqstp: the RPC transaction being executed
> - * @fhp: the NFS filehandle of the file just created
> - * @may_flags: NFSD_MAY_ settings for the file
> - * @pnf: OUT: new or found "struct nfsd_file" object
> - *
> - * The nfsd_file_object returned by this API is reference-counted
> - * but not garbage-collected. The object is released immediately
> - * one RCU grace period after the final nfsd_file_put().
> - *
> - * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
> - * network byte order is returned.
> - */
> -__be32
> -nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		 unsigned int may_flags, struct nfsd_file **pnf)
> +		  unsigned int may_flags, struct file *file,
> +		  struct nfsd_file **pnf)
> {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, false);
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
> }
>=20
> /*
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index b7efb2c3ddb1..ef0083cd4ea9 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -59,8 +59,7 @@ bool nfsd_file_is_cached(struct inode *inode);
> __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		  unsigned int may_flags, struct nfsd_file **nfp);
> __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		  unsigned int may_flags, struct nfsd_file **nfp);
> -__be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		  unsigned int may_flags, struct nfsd_file **nfp);
> +		  unsigned int may_flags, struct file *file,
> +		  struct nfsd_file **nfp);
> int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
> #endif /* _FS_NFSD_FILECACHE_H */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index bd880d55f565..6b09cdd4b067 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -735,7 +735,7 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 	__be32 status;
>=20
> 	status =3D nfsd_file_acquire(rqstp, &cstate->current_fh, NFSD_MAY_WRITE =
|
> -				   NFSD_MAY_NOT_BREAK_LEASE, &nf);
> +				   NFSD_MAY_NOT_BREAK_LEASE, NULL, &nf);
> 	if (status !=3D nfs_ok)
> 		return status;
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7b2ee535ade8..b68238024e49 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5262,18 +5262,10 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *=
rqstp, struct nfs4_file *fp,
> 	if (!fp->fi_fds[oflag]) {
> 		spin_unlock(&fp->fi_lock);
>=20
> -		if (!open->op_filp) {
> -			status =3D nfsd_file_acquire(rqstp, cur_fh, access, &nf);
> -			if (status !=3D nfs_ok)
> -				goto out_put_access;
> -		} else {
> -			status =3D nfsd_file_create(rqstp, cur_fh, access, &nf);
> -			if (status !=3D nfs_ok)
> -				goto out_put_access;
> -			nf->nf_file =3D open->op_filp;
> -			open->op_filp =3D NULL;
> -			trace_nfsd_file_create(rqstp, access, nf);
> -		}
> +		status =3D nfsd_file_acquire(rqstp, cur_fh, access,
> +					   open->op_filp, &nf);
> +		if (status !=3D nfs_ok)
> +			goto out_put_access;
>=20
> 		spin_lock(&fp->fi_lock);
> 		if (!fp->fi_fds[oflag]) {
> @@ -6472,7 +6464,7 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp, struct nfs4_stid *s,
> 			goto out;
> 		}
> 	} else {
> -		status =3D nfsd_file_acquire(rqstp, fhp, acc, &nf);
> +		status =3D nfsd_file_acquire(rqstp, fhp, acc, NULL, &nf);
> 		if (status)
> 			return status;
> 	}
> @@ -7644,7 +7636,7 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp=
, struct svc_fh *fhp, struct
> 	struct inode *inode;
> 	__be32 err;
>=20
> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> +	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, NULL, &nf);
> 	if (err)
> 		return err;
> 	inode =3D fhp->fh_dentry->d_inode;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index c852ae8eaf37..7c6cbc37c8c9 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -981,43 +981,6 @@ TRACE_EVENT(nfsd_file_acquire,
> 	)
> );
>=20
> -TRACE_EVENT(nfsd_file_create,
> -	TP_PROTO(
> -		const struct svc_rqst *rqstp,
> -		unsigned int may_flags,
> -		const struct nfsd_file *nf
> -	),
> -
> -	TP_ARGS(rqstp, may_flags, nf),
> -
> -	TP_STRUCT__entry(
> -		__field(const void *, nf_inode)
> -		__field(const void *, nf_file)
> -		__field(unsigned long, may_flags)
> -		__field(unsigned long, nf_flags)
> -		__field(unsigned long, nf_may)
> -		__field(unsigned int, nf_ref)
> -		__field(u32, xid)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->nf_inode =3D nf->nf_inode;
> -		__entry->nf_file =3D nf->nf_file;
> -		__entry->may_flags =3D may_flags;
> -		__entry->nf_flags =3D nf->nf_flags;
> -		__entry->nf_may =3D nf->nf_may;
> -		__entry->nf_ref =3D refcount_read(&nf->nf_ref);
> -		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> -	),
> -
> -	TP_printk("xid=3D0x%x inode=3D%p may_flags=3D%s ref=3D%u nf_flags=3D%s =
nf_may=3D%s nf_file=3D%p",
> -		__entry->xid, __entry->nf_inode,
> -		show_nfsd_may_flags(__entry->may_flags),
> -		__entry->nf_ref, show_nf_flags(__entry->nf_flags),
> -		show_nfsd_may_flags(__entry->nf_may), __entry->nf_file
> -	)
> -);
> -
> TRACE_EVENT(nfsd_file_insert_err,
> 	TP_PROTO(
> 		const struct svc_rqst *rqstp,
> @@ -1079,8 +1042,8 @@ TRACE_EVENT(nfsd_file_cons_err,
> 	)
> );
>=20
> -TRACE_EVENT(nfsd_file_open,
> -	TP_PROTO(struct nfsd_file *nf, __be32 status),
> +DECLARE_EVENT_CLASS(nfsd_file_open_class,
> +	TP_PROTO(const struct nfsd_file *nf, __be32 status),
> 	TP_ARGS(nf, status),
> 	TP_STRUCT__entry(
> 		__field(void *, nf_inode)	/* cannot be dereferenced */
> @@ -1104,6 +1067,17 @@ TRACE_EVENT(nfsd_file_open,
> 		__entry->nf_file)
> )
>=20
> +#define DEFINE_NFSD_FILE_OPEN_EVENT(name)					\
> +DEFINE_EVENT(nfsd_file_open_class, name,					\
> +	TP_PROTO(							\
> +		const struct nfsd_file *nf,				\
> +		__be32 status						\
> +	),								\
> +	TP_ARGS(nf, status))
> +
> +DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open);
> +DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open_cached);
> +
> TRACE_EVENT(nfsd_file_is_cached,
> 	TP_PROTO(
> 		const struct inode *inode,
> --=20
> 2.39.0
>=20

--
Chuck Lever



