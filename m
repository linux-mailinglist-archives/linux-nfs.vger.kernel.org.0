Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96016835B0
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjAaSwL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 13:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjAaSwK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 13:52:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8486B2738
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 10:52:08 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIhrUJ025726;
        Tue, 31 Jan 2023 18:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yX7bjBPn77PsX0SOagDqyTf3tHm9wTfah+pQBmGqpl8=;
 b=IyX6GzM5SRbsiWXCxDsp1BXOmI9l/mLlqpY5kG2hUEUuqGz5xV+07Dll00NBYRtdFknO
 ChvdoEkN4/+QJghCLqrp84EV1/BFpD8gbXEMSIsRt79p1QelSHHGKfkCuWlRJUTUK7rQ
 aExY+oTi1bCFD+Unidc8DkCGn0UvgqVy47vqnHw0uJ62ahMc4t+RE5JieBTpXgtehia6
 LUJiFO1B5MGjyoUyJXWURR9AYcOhjRwNuw9pnIk+Ku4Avb44qd4Y4ubRhxXA8QOG9Syj
 Rx32HVEZGLovA/uMDlHFwX+JV9GeUMsh+rRFCGOWpmcPTXaQjc5P2wdPRxag/+OufPdi 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvqwxg8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 18:52:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VI5knS035966;
        Tue, 31 Jan 2023 18:52:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct56c7tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 18:52:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L40RkIm2Gku1qvnWWWctruyYkaO6AbV/P7Rzk8nuyMT9qdW17UqJ8wk+RYVxDikkWyt3V46EqHmi9Yl/bNC4klVmXkSI7UIlgTTp6vGUtVriwobc0vx96IIG6I29QWuyD1Szi0mDCiP/NjuXcvB3wSprU+e4non9Y27TBkEbuGCMoMRslYVk3Tv9PZ15KRwCdgia0IbNq6mE0iMXRVL+LnuSssNpxZoU7K4vqU1IFmuT1edpmM5QfrvZKC2FaVTMKLwDH0k1xD0rI6QRRKVIknV3Adwet79aAfnTQj0ZnAlcwjvsVrmfGVNrp4cbK4XLSw+YGyfdN314VVyZZ72ErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX7bjBPn77PsX0SOagDqyTf3tHm9wTfah+pQBmGqpl8=;
 b=RO92ySCHVtb5+oebJPO2aJ8SRdu4PGtUqJyeKnwnQPCaL7ul4/UQWWa89SWX7tTKQKbfnRuR1Cu3QCXWdLKmQYj/D3Dgca4YN9lmf4x1aNX0PVOML/ZTZckXW5c22eNF3NUSpU3pzG8sDhcAh1BZu0NgAMUWzoriDVCKzva7YEGAgnCCgqrbHxCME2SvnVSyOitGzS5NGPC1t1V55PpvxgO/VHhh4ojL5venNH/awJ88skGn47iYxfY3+uea8nFa5/n2fnR3b4Y4avZhRjBQDj7LEw6o9iJHg1YLe4EZYtPAEPsdUFQJKFMdff5fQRpj90yXYYrPw6tz/6mPAOE/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX7bjBPn77PsX0SOagDqyTf3tHm9wTfah+pQBmGqpl8=;
 b=aXN7Eau2UaX9x6RgxDgapHJxvvNKE73c25Kkt+e16dfF4QFVaqcLdb4bHMDez5+bXa7xPdGEsIN6RowhVBxYqcsLgnkkhyXjZ35BXWEI10BNxFe3pHf6FFk73pwzcjF/H0sbOsUoPa3Pu7ok+sfKJYOsswWjnwU9pIL2LWnjUnA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6137.namprd10.prod.outlook.com (2603:10b6:208:3b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19; Tue, 31 Jan
 2023 18:51:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 18:51:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Andrew J. Romero" <romero@fnal.gov>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfk4CJ0DwDhNkGXE9jEOOJtYK64haaAgAAU2QCAAB9oAIAABtoAgAASpQCAAAetAIAABS+A
Date:   Tue, 31 Jan 2023 18:51:59 +0000
Message-ID: <884655AA-804E-4AD8-8469-04EE3AE75476@oracle.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
 <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com>
 <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <25395E08-073E-4572-A46D-A2228DB0212E@oracle.com>
 <SA1PR09MB7552B00147DBC9200BB8CDBAA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB7552B00147DBC9200BB8CDBAA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6137:EE_
x-ms-office365-filtering-correlation-id: 574e0f8d-1d45-46d7-3bf9-08db03bc3bf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kASInRYc6/y2/69LY3dgUsROYYBu92WRMwtM6dnqth9BwKc8FOvpy5n8uP7QTpUtgI2qoLSNEUY7hu/6jU8fqoFRukfmL6B9L8YQwe5R84UPSd4/DvlXXp0QajI7eJ5BgMMHJofZCLVPZvq+I9u/cAPrhRYI676qrl6ijB5s4fAot3D06kgRMXiyC+XIn5bLtC7BCPRdt4X0fx5BkH1bBm62ifqlbUibTzFebaG5cT36zKxC52KzoMAzgVdQmIQX7TBs88rlXHD3P+VFKfvu13BOY7bSpRYKFhy65a+7+a/XLAAiQXfI0vzgKaUgQLXqodnOkodQhUusbaqFyBzE7DtgoPW2q9GGK2ZOMghCnveJa7V87bBJ0Gf5Tv7D5mkx7HhlsHA91Zg5w0jLaYmpD4CEDQk0/ZEM99d2HgLP1/PWv+rDB2XhG2udTODc3FfIoT4nPOIF8eO9KyUEg6126tWyJm9uc7KKvrQXdKUfFROGkn1hpP/2bopKNZ7ccR5Gofe4sQ0Bcb0coZzObZnT57Nbp+wHlaMsLkWGJvKveS+CIU/D1qjyy9uoexoNaMXyzeb8rPqK1Au8QqVi3yMdz6E9+D+VjsjTXwiig9yThmYKzFkh0Ew9Pb3AlLUv8FIU752XUI0Y4Jor7RVgY1S9b08lecnwN0a3i5D1kqRHUXmjnkFPM97NjyHyv51vkScwpnvRC/6nX4CtGKh6IMw6xN0fhoVYnbcW2d72CwZwA4M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(66476007)(66446008)(66556008)(4326008)(66946007)(64756008)(6916009)(91956017)(41300700001)(53546011)(8676002)(8936002)(316002)(76116006)(5660300002)(33656002)(54906003)(36756003)(2906002)(478600001)(6486002)(186003)(6512007)(26005)(83380400001)(6506007)(86362001)(38070700005)(2616005)(71200400001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ODFQEquIAbiukLpTA43YfHQ11Bxv8qApFS7WD7R1swzRlDWOxH/FIMBl5ELF?=
 =?us-ascii?Q?w1UgFyj23nCY9xvi56dEYKqJirgJgSJ2lodJlQ47GvZjmuSAzcLYM4ukcuof?=
 =?us-ascii?Q?6ufznOZS0FD1+ARjt8jvIjQXexFzbdjHC1mlApZ5X8NNXJweKlQI6EKcA3y3?=
 =?us-ascii?Q?mDJpxrmOJ47sexus+vVwq+GpolFkjuLRgQnJZldSVJb8w6W+9234673smCTX?=
 =?us-ascii?Q?oWupkZQL/i+ggyJF6OIbH0CfgXtuqs/7x4vgsqCxCFand+84Xdpt00XJZ2Ca?=
 =?us-ascii?Q?DPqFyJyJtB2uO4b7HcEcSEq96FsRl1+dSKBQ+AqCgSVq7zGm3sY4vYmIP2gb?=
 =?us-ascii?Q?teVSip6KDkGmlr+jOcWXGkGxIkJZ9msnFwigvitNTJfozY9er2NlQOEnxIcX?=
 =?us-ascii?Q?3YkdIoCbk2unpCizL5RC3RmqA8e5wTsyBRKC4t9UzV951YJkXCLRdP4Q9aQ1?=
 =?us-ascii?Q?L5EX/IkfRZL7Xeyx7x4aZKlSxUcNIe5ssK94cyYq/7KtLLRujrcm702CXvUs?=
 =?us-ascii?Q?/THC36Cz67DWbS74jEQ4cvDOy8BTz37n8QvU3hkaxSqPFOlShaCzOYvv/wXB?=
 =?us-ascii?Q?L01Hs4xrzKW7/vi1P14m408lyJewxXJNVUxwrS0TjLkTjyv1xTmtbiXhuTYE?=
 =?us-ascii?Q?yka2xVhofM9asMYECsknfrTluiriT2Ae34hKqcU0hYanHsRhDSK7LqoXiRUj?=
 =?us-ascii?Q?uWvAfoNxFzgM7sDi7IOkmnit10FM2ZT+L2q6DbR27wSZfTbeAO/OYfspfc19?=
 =?us-ascii?Q?InPytIALJh0Jo+A2NcCejBm5uBEywE9VYD8ga0iE+HmU7SZe4QsccibKGQYq?=
 =?us-ascii?Q?CC4+zMRaZhwm4pupeU92O19aZocKJlBQir7czvJjPSbaKKCoGsJCXaFd+rLJ?=
 =?us-ascii?Q?4CPgo5SvpECfVFjf5yudYuqiTPF4tY0hVk+eToXsTA130LyxgVnwlr7kVdj1?=
 =?us-ascii?Q?wxoN7xG8eBmd/DznxdYs54/7G71a4taNQZsYSI1NlvEApPTOuHO9nX6+wrKy?=
 =?us-ascii?Q?M9jhrR8a0EjaV4+9OlPi/vflZbIgqNFiv1N4YbzkatLSI0i2Ux9d4jRISZfi?=
 =?us-ascii?Q?+8yVMfOIwxYifQcKaFYZIJvpN6vuKzdVofB7qGRZdhRc/WSwaN/f7wqH1wlx?=
 =?us-ascii?Q?5NhKj9gu6xp8EuBr4JThLKP61Ci7RC1HgJd/p8PhsYHUOvaNqndIAMQQ4gC6?=
 =?us-ascii?Q?oxXmcecey/fs8y7OQIP7rfinZSi7xI1I7mCb42xiM1yEQgWm60ZBilfKDJpJ?=
 =?us-ascii?Q?eIozkHodyGpWCTKhcIN+b3aShuS1jTjIL9HTBZ/E4y+eRgM2r4+kv5Tl0Fyh?=
 =?us-ascii?Q?JTx9WRj6ickHPbE/mULERIJblOcryLmydPRpAFpS60tI+jn4uERGgveCxzt7?=
 =?us-ascii?Q?Bt8mf5hllwh+j2re41jCq0RYtx2mUglfgEZvAVwEm3wuUoYEruIf8EWdFPxN?=
 =?us-ascii?Q?vq6UUoMir6XRzdvoZwhIXo5Bk5z2DgalMpgyzbN15FTBxV8izu95W87myG5a?=
 =?us-ascii?Q?woxJedpdNbKj/pzzf+yzxd3u8FyEnQiicW6xXY75D+gSeJvuCJdVYcYHyVru?=
 =?us-ascii?Q?1/gnJU/BNro8KPmfeyhLm3hRmvpS/RR+chLVLjSiR3lI2OONzThdR21WWpbC?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB61EB66EC0D29468AC65D26A32F7C70@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eAYfq/qwlO9Fiair3VWpV9Uy8C6MGHuapgLdS3okMUjejoHuq+REINucd4yB08+wz1xxyS1nYfag5PgnEnU4nlkHETtFHr9EY8aoVVg+fMvG65gK277ZEwStheWB8vDsQjs70QcAulNUgvXh9IHDxzoMWXP6Dq/OqR3veKsE5s9hCt+69+zoQscpJZ0D2HMBhgcBASByjjdI4LNTy/dZk3Y8YBMuUC5sKShA5Vu26nxUSQTamgWkzF4mDyBGnr4KDeK2if/ey32NQFw8cC1hvXWZrARdxJW+5lEnOtabemO1lNJpzjRSuL1HIksZC/vYwTAoSYqPWdF1za4GrUIB2Kf4JdrzyViPf91sgYvSWxJFxp8LYwooz+pUQ/ziU/nhPzeGD1iAuotCvLoPKF7SAjRFfBoRMCajA7Ip6RzmNWuHpYxBM+ZraJDxut9uYUUakrBIGJ07tMXVTp5pQTbddBsIk3q8ReEAOiWMk0y4SYFVaIULFtUQuuPf0x7WtVTbE6H24o+5OGSh7WsTNqbH0r7VGi3JPr/xEdpoHXGcK+SC3G7igAW9ybWavzAgXCSD9LlS09cGiNkAUBtxLb1d2VNoswuc7HGwlgNsjwSl34Fe9WGSt3hQfFpRq/hRmYM0XcXs08FhVP9CvQBHkpWvoxZPmVmjbbGqxpMzVVQs4DpZi+wxncPmzNRFJm85sU8sjEzKZRuERnsb16PZuV4yCEO4fa0ovuk8cDNyCG7iSokwaYafO+w67sx3fRhaoOtIqTKjU5H8bI6Rx2bj6w/PwFKxKNLyLeSYTcSAm1RPSDlsJK0GMrZpcPxFQXf8b1u/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574e0f8d-1d45-46d7-3bf9-08db03bc3bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 18:51:59.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gw/hyblw9AEaOt9P3KPXdUKXaRC/LoK8cxlFHW2EtYNZKHAoyE2vaW7grMalrr4SNNk6P0N47EQlHNR/a96CCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=866 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310163
X-Proofpoint-ORIG-GUID: gokt8Uahb5vfJLmNeFn_pJMiR-WDGEBD
X-Proofpoint-GUID: gokt8Uahb5vfJLmNeFn_pJMiR-WDGEBD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 31, 2023, at 1:33 PM, Andrew J. Romero <romero@fnal.gov> wrote:
>=20
>> That's not the way state recovery works. Clients will reopen only
>> the files that are still in use. If the clients don't open the
>> "zombie" files again, then I'm fairly certain the applications
>> have already closed those files.
>=20
> Hi
>=20
> In the case of my test script , I know that the files were not
> closed explicitly or on script termination. ( script terminated
> without credentials ) .   By the time my session re-acquired credentials
> ( intentionally after process termination) , the process was already term=
inated
> and nothing, on the client, would ever attempt to clean-up the
> server-side "zombie open files"
>=20
> The server-side pool usage caused by my intentionally
> bad test script was not freed up until I did the cluster resource migrati=
on.
>=20
> Question:
> When a simple app (for example a python script ) on the NFS client=20
> simply opens a text file,  is a lease automatically, behind the scenes,=20
> created on the server. If so, is the server responsible for doing this:
> If the lease isn't renewed every N minutes, close the file.

Almost. The protocol requires:

After the client reboots, when it opens its first file, the client
does a SETCLIENTID or EXCHANGE_ID to establish its lease on the
server. All OPEN and LOCK state is managed under the umbrella of
that lease (and that includes all files that client is managing).
The client keeps the lease alive by renewing the lease every minute.

If the client reboots (ie, does a subsequent SETCLIENTID or
EXCHANGE_ID with a new boot verifier), the server has to purge all
open file state for that client.

If the client fails to renew its lease, the server is free to do
what it wants -- it can purge the client's lease immediately, or
it can wait until conflicting opens or locks come from other
clients and then purge some or all of that client's lease.

If the client can't or doesn't CLOSE that file, it will remain
on the server until the client tells it (implicitly by not
renewing or explicitly with a fresh ID) that the state is no
longer needed; or until the server reboots and the client does
not re-establish the OPEN state.

Therefore, rebooting individual clients that have accrued these
zombie files should also clear them out without interrupting the
file service for everyone else.

But again, we need some way to confirm exactly how this is
happening. Can you post your script, or capture client-server
network traffic while the script does its thing?


> By "simply opens" a text file, I mean that:   the script contains no
> code to request or in any way explicitly use locks


--
Chuck Lever



