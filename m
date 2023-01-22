Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2196770FA
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Jan 2023 18:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAVRLH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Jan 2023 12:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjAVRLH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Jan 2023 12:11:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4141B561
        for <linux-nfs@vger.kernel.org>; Sun, 22 Jan 2023 09:10:43 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30MBul01004006;
        Sun, 22 Jan 2023 17:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UpkYf1b44O+5BJ4HGdl3WPyMBG6P5bC+IBn5tmucGF8=;
 b=Oh1Rnb4wyJHwmyE0gwPudVbzNDkRHrma14/eE507IK+TmefPMyxfvuRkkvPZB9CKHlid
 VnxU2i9UuQ9MVvg4aa1EJHaZgAMKHXVB+PMequ8SK4VbxOBW8Mo/PEC8GhGt0EKMObn1
 WRe8+NqgYUwNhNyLL8AzRbRpvVU5x0wsxDL7kkmNNX7zLHhssC17qgyQnNKgx2iALS7N
 M/CxXxZLOm4ZMiOZKlZT7nbXVhMsILRObqLnLdIxQVVB5UpgRGlOG/03THiZoi79Y534
 2TuG3fMhCPtH1NIYWFrPI77zFPgxo39jmSeX8VwJhxTEMh6/HECp30CPmcNrNFw4nyl3 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c1h13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jan 2023 17:10:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30MGH6Hc004099;
        Sun, 22 Jan 2023 17:10:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g9eq4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jan 2023 17:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrRAGMIzMYmYRd6Z6oa+c8KOvPYTFaF8KdKjl4/lgpxukuzB95AC8kyYCS8jMUp9UUlhNB6Vgrj8lhHbMt0PtvYRCm1msvW68ReSxpDDB+/zcNinpiWburanF1bQaGwlRJhG1p3Ab4T57/+IZsEY+BmgZPgacf9bb2wUA11VxLNLFETdGlEL/cvv5/UmMR4bwokyIf7JInz3ZmEMsejFEIkbR3nBf1phMW7CQq6qOqP9NHC6zL2v52wmj4ZFIfT+MXWAbFrPKc33LV8fxIRTrXsyXUqoig6Fnd5JZRduZz3KwyV88rnvzdtG1HMkc97DFYqR3UdA16+rAYWbOYLH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpkYf1b44O+5BJ4HGdl3WPyMBG6P5bC+IBn5tmucGF8=;
 b=fQjxYEFKSZAuLLmUKD0J9pHfO7f5mpyK3YEf4EsZJbFiWI5bkfdnxRsx4oHh3BfC1CVpDy7HDA3XegNi0dpRJALD1rQAnoINZVnA9BKwqXCV+g/ScJ++kFTYuu3sxwIC8XeFVfcAzTF3rww78xBS076BmE9JtNZic8GMKTza9C1sf2wlnQiVnqRTnBH1P78Ow0yT4XlzuNL3itLpL7NShXRYUaoiCNfXs+LxkaPcRxBbIn+DgipWpbuNnvryUGP5T5XZqcYVqPW/8BTur+4/1O+IkDRWfzbAvbqIdOTDBCzkbkF1za37296CdW44Hk/sB2JdECRa7f24F4HRed5fLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpkYf1b44O+5BJ4HGdl3WPyMBG6P5bC+IBn5tmucGF8=;
 b=dQDUwcbM+6gSFtxb+cGIoxIBmbqQziHsEH6TDh+LVxVPzwEDO8hRA4lzRaib83Vpq1Hw1SoTZpxs3YedKPrwZf+Kqam4EraMPhhHvDcSJn0X015UtiKwvxW+TIcj6qhXxUB17jKNUKkCBI4rRNngxT8byIjI6okzhvuBAnUVJIY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5597.namprd10.prod.outlook.com (2603:10b6:a03:3d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.14; Sun, 22 Jan
 2023 17:10:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6043.014; Sun, 22 Jan 2023
 17:10:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Topic: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
Thread-Index: AQHZKqtMKSgqI33qoEK/JPELcgPtS66lMfqAgABiFoCAAIEkAIABHkYAgAILXICAAA8igIAABC4AgAABxoCAABVtAIABQ0wAgAAG1AA=
Date:   Sun, 22 Jan 2023 17:10:20 +0000
Message-ID: <6C812F9C-A645-4D36-B0CE-7884F259F63D@oracle.com>
References: <20230117193831.75201-1-jlayton@kernel.org>
 <20230117193831.75201-3-jlayton@kernel.org>
 <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com>
 <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
 <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com>
 <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
 <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com>
 <4577f120-9191-c138-299f-eeddc3652e8b@oracle.com>
 <80fd3e68dd5ed457bf38f4ff0a6086d568cc3cee.camel@kernel.org>
 <D14F7839-3E42-4592-BF11-4A19905D5AA4@oracle.com>
 <f52f1cbf-aed4-b0f3-2066-9aa67e2a6003@oracle.com>
 <71DC929D-D10B-4721-8327-301A7E65312F@oracle.com>
In-Reply-To: <71DC929D-D10B-4721-8327-301A7E65312F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5597:EE_
x-ms-office365-filtering-correlation-id: 7d0491b1-dc94-40c1-8e50-08dafc9b8ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KkcDER1MroV7puSF2rqxzEWRGCYxC0m2BdQ07pMqzdUaSeu7nxYFuiLFW40M5Cjt/8CaR6QtsOtX6xunCoKsZUJNeE9j1hpT7VENTyaW4G7+S8I4eb+NB1jhZjZDwA/xPBIo+qquopYBcD8Q4xQzjOIYAn2IKW0q72srbrb/MK6bHKVQ7uCdQwvWI2FOvF4Zzk0ytLAIzIorTBl3iUQI047mQkMuck4qSw/NqScqplG0RxOkj0+p0fOskKdvS1hQs+Cu8lTssyHR8flfKdtTu/qwANCXqYC6Om5I+B4CiY2qHltjb+Wtd9M2LAuFKceffcsUkeTTXwCf3UZVFpZG385cl6z26iBqDrxLimYekLkz6z89ST/lJ2yH2VVknCdqLQ5/aoZIhIY8P/dxOJVAnN5BeSsVbD4oyPlBhbvYfqzVrDK223cK2+9BMZSmP8chnM7AxV+UF3NEhRSPYV1El7uNimzQXfWSUFv9g7GQSaOTurV7xnDLxnfKEIZB7TsHXth49efLPI7tJPGneIhwdjZ/oAUlEUuBSgVy+jK2yH8IMk1tov2HuN1VIvi4rx1ifDYfpCIHVCmYdWUpyfmyMPEkvwrb4Fa0vc5NQcP7kEE8sQe0tCmNwGNfeFIE1TpBCxwcd+lXIcft4UBoicyhZyHPnUeRWUefxd6V+/3wbPlb/rx99jkAfoxGr6nzYtXQLaIx1vKdMuI+60+DjeKTRAk4oU1tSYI7sYAUhYDNvkDnKikSiSyS06Yf9yx86b6TUBzXBrs05MrdQ7e671bRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(122000001)(83380400001)(33656002)(38100700002)(38070700005)(86362001)(41300700001)(2906002)(5660300002)(30864003)(8936002)(4326008)(8676002)(6512007)(6506007)(186003)(26005)(53546011)(2616005)(316002)(54906003)(76116006)(66946007)(66556008)(64756008)(66446008)(66476007)(110136005)(91956017)(478600001)(966005)(6486002)(71200400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q85TG8KISDSKSplIh4lCyDzwuGmPD8T9m+9nvwerNulLnHCeVYWBjb23pc+l?=
 =?us-ascii?Q?aeYwroKCRYmAHGY4jgpxET7HxkiHco6s9XvO4LdB/44N7KqhisfxUjs7Xhzf?=
 =?us-ascii?Q?z4leEmc672HiCY7x49APeZMqN/mZP9b3hSSOrNI4x0lc6aC9dlncSIgd3OWB?=
 =?us-ascii?Q?tr9cVb4wmNHPUKSoC9iTTSlEdaYUwY3I4G3CcNs66NEbp4eilMAEWSFcrVE4?=
 =?us-ascii?Q?1GA9voMT/b2Hgj785lJB65YpYNuj/0IVtmQiIVsAiuU4svguJSTo0xsXUQe0?=
 =?us-ascii?Q?UkOpaYFrA8zYsDs0ql1KrR7S1QOT96tKVH47z2jUJMdgjNRgA01GB4LQSwjk?=
 =?us-ascii?Q?P2zuq8OrfNMBVoOtFRY2CAoCsthxjyOi/vygWe42SNK2zHYUHH90NIxfbjQf?=
 =?us-ascii?Q?+vjLRQmD7hS3C495/eLuAs2Rub1TDVfQREIQE1DgTMSyhX1pDy3uAixr408j?=
 =?us-ascii?Q?1mp4CagGSrn55vwYdi5hzTKj1KjCCLu5Cv15bZ00M75kbY/igSUTvzPduPIJ?=
 =?us-ascii?Q?g5yIiwQpb93/K4jzRyw+ciwYW6XR3JN2AKu/bWtJZfo0AU545zVX8fmMb2iP?=
 =?us-ascii?Q?62oYseNlUyEdQeKTWf86iTOak/Uw55UOUcHRKgAB26kqEBEuTHVzOFuf/JFi?=
 =?us-ascii?Q?uMINR9G7OC19iq0CXY/z5r3DW4bEazjqcG3rDa+NKbn95/5nQk9/Eoy0VNny?=
 =?us-ascii?Q?9nINJf77j7IXU4HBmY4WwQfszUkACDUCdpV74JHD7v3AErnIQyOvsGBS/Ju2?=
 =?us-ascii?Q?ChYdkHWJiTqDuQpcuBLrzwJzqCynbbfZfX/so3lxZeHv+i1jqc0yLrXaYIan?=
 =?us-ascii?Q?mR6+kNoKSnjj/plCaw7UHJ4n9ylNvbPHK4t9RzQVA07R4Jxo3gKUf2FD2jb0?=
 =?us-ascii?Q?7ginRaBOZtvbTiWtS9yvzEUAQ9ET+RXHN39c+UQ0QpbuzdBjTFH896PJ8Epu?=
 =?us-ascii?Q?OhPwe+/TmCRIX5H2aZI0HYbRfi8bgk6aQ4rW6+dtIwYRkD/FWihCBDM81PrT?=
 =?us-ascii?Q?+X5jpGBrHF7ISzT9coO+ktmfXYgIco4uvW/9dYJZWG3ydluLkPvXO8MjWwpY?=
 =?us-ascii?Q?RcChnTwmC0S41CjFV1gTYPxi+zd4LCZG7anRoS7i4+voVAzLPG8MnYxiTfmi?=
 =?us-ascii?Q?OtAXSWAagyQrIstpJOJVJU88cBzCMBWyzHwWYQbA5r2ZHvA8GEhomGw+HCg2?=
 =?us-ascii?Q?URhPLmuhpHLsZafmXl3lpgCGDaA3gmgemLnOEQKQOyCQW9NDYJcy6aktQ+3R?=
 =?us-ascii?Q?cEA0ZGzo/485onCaBatuUKHgoSisy1v1RRhcK6tv941wsfesqPyPAG/W4MPP?=
 =?us-ascii?Q?zZoeROfNkcP3savZF1W0FfUaIa+x2kn3Dj56Y9ZogmwxUaxLmJje3CbccuV2?=
 =?us-ascii?Q?b4XaO15+eIms8O/vNaO5CZWbukQYxFffIMWuRHHQStSSFNummFxTPNw0+MDe?=
 =?us-ascii?Q?ayZ5WTrUelhg1FxBDDzrgJSsd/+O3FGjOMRl4Uh1w+5lvs8s+g5q+I4QR61P?=
 =?us-ascii?Q?aO82JCf89f3kfSKkzqCsfV1hL4MNIFJEj9ELiYJyONzFO2lJzPxV/D2F83+l?=
 =?us-ascii?Q?ORhF+njCXsxrzIVR/OFFVEIyNZrUNX9mW6kCVC01zTTHRraolsayLvgu6F4c?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4224C082E85BA949BF236FC1ECE17751@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xYhn7MR5GuaoMTwzSd6AkZ/oso790O0ocmm8irQZXNlZeLmD6LQll9ioZEyqKnVxMafVLOoVCFJbrsoorPyMfcisbRCgFF0bInlFURDMmG+rkq7jGhJCKZGtFYEE74OEGDFJQEmxQb8ul0NWV2mZgh6xGu7RCiSjIw6kbgJm/h2+i+4XQglVZqEwesAqVt67jAc7FKuf++V6bogfpW2prVdsoR7nfr3RiOhict4imaxANjirblI0A8mUgUCumSUIp6ioUjT00Ia5n9i1yAU+eeducrJLaR8u1w7wcL5EawEsLeBAVEEULdcdLcv3Fo+tKd10g6kxPD5zHU3RkH1Ffr+urB2JzwHjKVycyOOs6ut8kA1mLDB2FRgLfl8oo2LoFnnoxVvz19vNwvbXDvASlf4vmxj6Xt0GgFqQ/W1jy/HT0wTmiet5CAaqfNB7juGSvyfmEJX3NCkKc+wFsUMAhdkii2atD3EYDhFWONM0Q2nDlwoZjmLmxZ7W1XJ443zl5n/H/TQvq5p/FbCSONt2v4pMdrXgFQFz5hjAZ27ZB1KsLoeytS+PIyQuy0+qrFAt+AI/4Xn5nV9oUlc7wgemZ5btOCQz1WoPgUYFADB0PHY+xp3kjCAX6R1t0vbTGIPckH7yoD8zfws28cKKt6Zp0cTLoVKsVW5z7D8TLzUlcdFxTCMKgskV8kEcAS1yjYQhpaD2CVy4goJtsRu+Bq6qe5qMFD6b6SAxFYJTqipd9BcszWlDzxPu5kqkgVGv8aXPfD36vV45kZ4P8AIHX+IO9s1DAbj6rSFgWAiVjjYyxEwnEXkHSSlqyz8debaFKvaC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0491b1-dc94-40c1-8e50-08dafc9b8ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2023 17:10:20.6293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzH5C9ZbZzR5xgKRBqXaOm7FyF17ZEufbWRqcy+Ft7jtIQNBRMv30vtbCsCHVFxJjZecbO+SEqsJuiklVIQiWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-22_14,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301220166
X-Proofpoint-ORIG-GUID: _5t2tvEthi2l4u7wWaDwIFVw50iqf1cK
X-Proofpoint-GUID: _5t2tvEthi2l4u7wWaDwIFVw50iqf1cK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 22, 2023, at 11:45 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>=20
>=20
>> On Jan 21, 2023, at 4:28 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>=20
>>=20
>> On 1/21/23 12:12 PM, Chuck Lever III wrote:
>>>=20
>>>> On Jan 21, 2023, at 3:05 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> On Sat, 2023-01-21 at 11:50 -0800, dai.ngo@oracle.com wrote:
>>>>> On 1/21/23 10:56 AM, dai.ngo@oracle.com wrote:
>>>>>> On 1/20/23 3:43 AM, Jeff Layton wrote:
>>>>>>> On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote:
>>>>>>>> On 1/19/23 2:56 AM, Jeff Layton wrote:
>>>>>>>>> On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>> On 1/17/23 11:38 AM, Jeff Layton wrote:
>>>>>>>>>>> There are two different flavors of the nfsd4_copy struct. One i=
s
>>>>>>>>>>> embedded in the compound and is used directly in synchronous
>>>>>>>>>>> copies. The
>>>>>>>>>>> other is dynamically allocated, refcounted and tracked in the c=
lient
>>>>>>>>>>> struture. For the embedded one, the cleanup just involves
>>>>>>>>>>> releasing any
>>>>>>>>>>> nfsd_files held on its behalf. For the async one, the cleanup i=
s
>>>>>>>>>>> a bit
>>>>>>>>>>> more involved, and we need to dequeue it from lists, unhash it,=
 etc.
>>>>>>>>>>>=20
>>>>>>>>>>> There is at least one potential refcount leak in this code now.
>>>>>>>>>>> If the
>>>>>>>>>>> kthread_create call fails, then both the src and dst nfsd_files
>>>>>>>>>>> in the
>>>>>>>>>>> original nfsd4_copy object are leaked.
>>>>>>>>>>>=20
>>>>>>>>>>> The cleanup in this codepath is also sort of weird. In the asyn=
c
>>>>>>>>>>> copy
>>>>>>>>>>> case, we'll have up to four nfsd_file references (src and dst f=
or
>>>>>>>>>>> both
>>>>>>>>>>> flavors of copy structure). They are both put at the end of
>>>>>>>>>>> nfsd4_do_async_copy, even though the ones held on behalf of the
>>>>>>>>>>> embedded
>>>>>>>>>>> one outlive that structure.
>>>>>>>>>>>=20
>>>>>>>>>>> Change it so that we always clean up the nfsd_file refs held by=
 the
>>>>>>>>>>> embedded copy structure before nfsd4_copy returns. Rework
>>>>>>>>>>> cleanup_async_copy to handle both inter and intra copies. Elimi=
nate
>>>>>>>>>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
>>>>>>>>>>>=20
>>>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>>>>>>> ---
>>>>>>>>>>>    fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>>>>>>>>>>>    1 file changed, 10 insertions(+), 13 deletions(-)
>>>>>>>>>>>=20
>>>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>>>> index 37a9cc8ae7ae..62b9d6c1b18b 100644
>>>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>>>> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct
>>>>>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>>>>>>        long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeo=
ut);
>>>>>>>>>>>            nfs42_ssc_close(filp);
>>>>>>>>>>> -    nfsd_file_put(dst);
>>>>>>>>>> I think we still need this, in addition to release_copy_files ca=
lled
>>>>>>>>>> from cleanup_async_copy. For async inter-copy, there are 2 refer=
ence
>>>>>>>>>> count added to the destination file, one from nfsd4_setup_inter_=
ssc
>>>>>>>>>> and the other one from dup_copy_fields. The above nfsd_file_put =
is
>>>>>>>>>> for
>>>>>>>>>> the count added by dup_copy_fields.
>>>>>>>>>>=20
>>>>>>>>> With this patch, the references held by the original copy structu=
re
>>>>>>>>> are
>>>>>>>>> put by the call to release_copy_files at the end of nfsd4_copy. T=
hat
>>>>>>>>> means that the kthread task is only responsible for putting the
>>>>>>>>> references held by the (kmalloc'ed) async_copy structure. So, I t=
hink
>>>>>>>>> this gets the nfsd_file refcounting right.
>>>>>>>> Yes, I see. One refcount is decremented by release_copy_files at e=
nd
>>>>>>>> of nfsd4_copy and another is decremented by release_copy_files in
>>>>>>>> cleanup_async_copy.
>>>>>>>>=20
>>>>>>>>>>>        fput(filp);
>>>>>>>>>>>            spin_lock(&nn->nfsd_ssc_lock);
>>>>>>>>>>> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *r=
qstp,
>>>>>>>>>>>                     &copy->nf_dst);
>>>>>>>>>>>    }
>>>>>>>>>>>    -static void
>>>>>>>>>>> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_fil=
e
>>>>>>>>>>> *dst)
>>>>>>>>>>> -{
>>>>>>>>>>> -    nfsd_file_put(src);
>>>>>>>>>>> -    nfsd_file_put(dst);
>>>>>>>>>>> -}
>>>>>>>>>>> -
>>>>>>>>>>>    static void nfsd4_cb_offload_release(struct nfsd4_callback *=
cb)
>>>>>>>>>>>    {
>>>>>>>>>>>        struct nfsd4_cb_offload *cbo =3D
>>>>>>>>>>> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct
>>>>>>>>>>> nfsd4_copy *src, struct nfsd4_copy *dst)
>>>>>>>>>>>        dst->ss_nsui =3D src->ss_nsui;
>>>>>>>>>>>    }
>>>>>>>>>>>    +static void release_copy_files(struct nfsd4_copy *copy)
>>>>>>>>>>> +{
>>>>>>>>>>> +    if (copy->nf_src)
>>>>>>>>>>> +        nfsd_file_put(copy->nf_src);
>>>>>>>>>>> +    if (copy->nf_dst)
>>>>>>>>>>> +        nfsd_file_put(copy->nf_dst);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>    static void cleanup_async_copy(struct nfsd4_copy *copy)
>>>>>>>>>>>    {
>>>>>>>>>>>        nfs4_free_copy_state(copy);
>>>>>>>>>>> -    nfsd_file_put(copy->nf_dst);
>>>>>>>>>>> -    if (!nfsd4_ssc_is_inter(copy))
>>>>>>>>>>> -        nfsd_file_put(copy->nf_src);
>>>>>>>>>>> +    release_copy_files(copy);
>>>>>>>>>>>        spin_lock(&copy->cp_clp->async_lock);
>>>>>>>>>>>        list_del(&copy->copies);
>>>>>>>>>>> spin_unlock(&copy->cp_clp->async_lock);
>>>>>>>>>>> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data=
)
>>>>>>>>>>>        } else {
>>>>>>>>>>>            nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file=
,
>>>>>>>>>>>                           copy->nf_dst->nf_file, false);
>>>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>>>>        }
>>>>>>>>>>>        do_callback:
>>>>>>>>>>> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
>>>>>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>>>>>        } else {
>>>>>>>>>>>            status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file=
,
>>>>>>>>>>>                           copy->nf_dst->nf_file, true);
>>>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>>>>>>>>>>>        }
>>>>>>>>>>>    out:
>>>>>>>>>>> +    release_copy_files(copy);
>>>>>>>>>>>        return status;
>>>>>>>>>>>    out_err:
>>>>>>>>>> This is unrelated to the reference count issue.
>>>>>>>>>>=20
>>>>>>>>>> Here if this is an inter-copy then we need to decrement the refe=
rence
>>>>>>>>>> count of the nfsd4_ssc_umount_item so that the vfsmount can be
>>>>>>>>>> unmounted
>>>>>>>>>> later.
>>>>>>>>>>=20
>>>>>>>>> Oh, I think I see what you mean. Maybe something like the (untest=
ed)
>>>>>>>>> patch below on top of the original patch would fix that?
>>>>>>>>>=20
>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>> index c9057462b973..7475c593553c 100644
>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>> @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct
>>>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
>>>>>>>>>          struct nfsd_net *nn =3D net_generic(dst->nf_net, nfsd_ne=
t_id);
>>>>>>>>>          long timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeo=
ut);
>>>>>>>>>   -       nfs42_ssc_close(filp);
>>>>>>>>> -       fput(filp);
>>>>>>>>> +       if (filp) {
>>>>>>>>> +               nfs42_ssc_close(filp);
>>>>>>>>> +               fput(filp);
>>>>>>>>> +       }
>>>>>>>>>             spin_lock(&nn->nfsd_ssc_lo
>>>>>>>>>          list_del(&nsui->nsui_list);
>>>>>>>>> @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
>>>>>>>>> nfsd4_compound_state *cstate,
>>>>>>>>>          release_copy_files(copy);
>>>>>>>>>          return status;
>>>>>>>>>   out_err:
>>>>>>>>> -       if (async_copy)
>>>>>>>>> +       if (async_copy) {
>>>>>>>>>                  cleanup_async_copy(async_copy);
>>>>>>>>> +               if (nfsd4_ssc_is_inter(async_copy))
>>>>>>>> We don't need to call nfsd4_cleanup_inter_ssc since the thread
>>>>>>>> nfsd4_do_async_copy has not started yet so the file is not opened.
>>>>>>>> We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unle=
ss
>>>>>>>> you want to change nfsd4_cleanup_inter_ssc to detect this error
>>>>>>>> condition and only decrement the reference count.
>>>>>>>>=20
>>>>>>> Oh yeah, and this would break anyway since the nsui_list head is no=
t
>>>>>>> being initialized. Dai, would you mind spinning up a patch for this
>>>>>>> since you're more familiar with the cleanup here?
>>>>>> Will do. My patch will only fix the unmount issue. Your patch does
>>>>>> the clean up potential nfsd_file refcount leaks in COPY codepath.
>>>>> Or do you want me to merge your patch and mine into one?
>>>>>=20
>>>> It probably is best to merge them, since backporters will probably wan=
t
>>>> both patches anyway.
>>> Unless these two changes are somehow interdependent, I'd like to keep
>>> them separate. They address two separate issues, yes?
>>=20
>> Yes.
>>=20
>>>=20
>>> And -- narrow fixes need to go to nfsd-fixes, but clean-ups can wait
>>> for nfsd-next. I'd rather not mix the two types of change.
>>=20
>> Ok. Can we do this:
>>=20
>> 1. Jeff's patch goes to nfsd-fixes since it has the fix for missing
>> reference count.
>=20
> To make sure I haven't lost track of anything:
>=20
> The patch you refer to here is this one:
>=20
> https://lore.kernel.org/linux-nfs/20230117193831.75201-3-jlayton@kernel.o=
rg/
>=20
> Correct?
>=20
> (I was waiting for Jeff and Olga to come to consensus, and I think
> they have, so I can apply it to nfsd-fixes now).

Or not...

This one does not apply cleanly to nfsd-fixes, but does apply to nfsd-next.
Also, the patch description says "clean up" and does not provide a Fixes:
tag. So, either:

 - Jeff needs to test and redrive this patch against nfsd-fixes if we all
   agree that it fixes a real and urgent bug, not a potential one; or

 - I will apply it as it stands to nfsd-next; or

 - You were referring to something else in 1. above.

Let me know how you'd both like to proceed.


>> 2. My fix for the cleanup of allocated memory goes to nfsd-fixes.
>=20
> And this one hasn't been posted yet, right? Or did I miss it?
>=20
>=20
>> 3. I will do the optimization Jeff proposed about list_head and
>> nfsd4_compound in a separate patch that goes into nfsd-next.
>=20
> That should be fine.
>=20
>=20
>> -Dai
>>=20
>>>> Just make yourself the patch author and keep my S-o-b line.
>>>>=20
>>>>> I think we need a bit more cleanup in addition to your patch. When
>>>>> kmalloc(sizeof(*async_copy->cp_src), ..) or nfs4_init_copy_state
>>>>> fails, the async_copy is not initialized yet so calling cleanup_async=
_copy
>>>>> can be a problem.
>>>>>=20
>>>> Yeah.
>>>>=20
>>>> It may even be best to ensure that the list_head and such are fully
>>>> initialized for both allocated and embedded struct nfsd4_copy's. You
>>>> might shave off a few cpu cycles by not doing that, but it makes thing=
s
>>>> more fragile.
>>>>=20
>>>> Even better, we really ought to split a lot of the fields in nfsd4_cop=
y
>>>> into a different structure (maybe nfsd4_async_copy). Trimming down
>>>> struct nfsd4_copy would cut down the size of nfsd4_compound as well
>>>> since it has a union that contains it. I was planning on doing that
>>>> eventually, but if you want to take that on, then that would be fine
>>>> too.
>>>>=20
>>>> --=20
>>>> Jeff Layton <jlayton@kernel.org>
>>> --
>>> Chuck Lever
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--
Chuck Lever



