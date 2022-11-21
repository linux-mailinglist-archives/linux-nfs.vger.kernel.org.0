Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78952632757
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Nov 2022 16:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiKUPIL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Nov 2022 10:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiKUPHp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Nov 2022 10:07:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4016B28E25;
        Mon, 21 Nov 2022 06:57:47 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALENw9r013956;
        Mon, 21 Nov 2022 14:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lx7z3XfHrDJdktmeIsb7sIokJ+lbQhNbsRHXhm1cqAY=;
 b=wybtHwUkauMOaTr3X3WCY3UaKu/qvCnpVxn6Y0sFarUSQOwkAQix329BtMVssfBKYGNc
 zF3Aq92XDRUbJJoV/R/nUDNUraknX3TVCU1vTmBv958KUSFq6rPxttEY5RgTSAe5MViJ
 I20EEOV/i/W1WW4I4rpQLk+CbNufjogSbIKwxHVWWBTO67pV+ueT5QSZUBJOh+lSO3Kx
 Xay9Y0DtazGgm9rvMW37UxaZqTnMtX0sOeKU04PLUA0tq3n2YUoO/eMSPulVsOCf9JBZ
 cp33XIyzhkF0/XdHljcjoJXFzX4WTnob4WGtrCn8TbIbPI242HGeHUS6tsy3ndQ5D3Eh cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m0afr08ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 14:57:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALDxBhW007412;
        Mon, 21 Nov 2022 14:57:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk42jmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 14:57:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoDgVlOqxX7CfQilRrCwya0saKzkfJyiH7PVuJ8XqKHTrH18UwWVrOMvti3IIo29z/A8ZuiKxysKmVtuN0ACj5niZw8k0IJqpuGay6emKEvRtYPJ2sDz9Gw2NBKtAUb3bA8Hd0utwHDkKh0M2W+cREzyyckHfPmyNgYO0WX7MUWcs4D0u7hl3OQdWOEnP0jasWuZgQO8/u4KRX48cSfOJhhhXElRTrGqYY5GYNMwhMTWpQzSoxRxXfkx4EBzP8BgTMNgKP1vZUnyDA7Rrrm4yr7SUoVJ8Myd0a9Ubc0BBHp03TROl5NfYkEU9ZgiKpNYeSwvQjAPW4wN/SWN/8DqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx7z3XfHrDJdktmeIsb7sIokJ+lbQhNbsRHXhm1cqAY=;
 b=EdunlelBpT4OVJL/2xJYUX9cgA60tTGv7XdgXl8jk0yCstT3Mr3mq+vNyRYADXApxh20Nd1bUck4ymaCtRV97DHHwtY+pRr3PNNLBPuJsvgL8yd7i4CodyASTlTHLxTTAvUX1xvDlTicGV6gAr2zX10xkoYH1ehP3aMGd1swwHRLF2ZWKrgM44td6BvdLcFC2ddwdjVtpplIqmS3eWlfJ5lJ0abAC0+6o9Jf0S1a0qR6RtOUfyoq1cTMFWda4ReqKiR1mYqjLK0mM0X8N8IrRvwjPCrRftTx3YAdLHMcmu6hxAfBMpQtt8ty4JhxGxwlbjHdw6q5iKkTSGsK6t+pHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx7z3XfHrDJdktmeIsb7sIokJ+lbQhNbsRHXhm1cqAY=;
 b=M5n97rVPZ4DSdG9KfLQjaEjHrXXL2BMchryseUAyYjrJhISFy8xz+8CDC5raklhyR/oxsD/Rn43rEZeBIMk99ahzS3u0xJsFy/5N85GAXXIdiZNvULdZLcitrj0qR1H/Aib7WIQi+YAFB5LhZpX/krpe+FjV6YHCjdTk/O/cpp8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6986.namprd10.prod.outlook.com (2603:10b6:510:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 14:57:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%4]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 14:57:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3] trace: Relocate event helper files
Thread-Topic: [PATCH v3] trace: Relocate event helper files
Thread-Index: AQHY+pDawo+ItAT0Q0Wa9gN3wMKjXa5JfgmA
Date:   Mon, 21 Nov 2022 14:57:34 +0000
Message-ID: <8D18C977-79DB-4D03-B435-77B395A07ACE@oracle.com>
References: <166869513208.318836.8777065369440403777.stgit@klimt.1015granger.net>
In-Reply-To: <166869513208.318836.8777065369440403777.stgit@klimt.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6986:EE_
x-ms-office365-filtering-correlation-id: ed7c12c3-33fb-47ec-a7ab-08dacbd0b8dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: guKGF8sIi9vo1sLSnDjgn7IUlP1KjEVV3rSy/ZkBpC2n7F1mTiwKYjeZDNoklVOqmB9FPqbFr0ueYvbfv+iJnjXXX8HTsdYzAvaOyHcGkK1SzMGSZdwGb3IolxdSp7LHL7kqx4vjwQTyF+GSi5GifJu5xT9iDJ+7hp3Q6mEVAHXbllNTo+r8mOlTfLgs5Uf+1Xc04IbXyynK3jn2iGnzWKSd0wvg8iD3GqabiQXiZvIdBfR89jfg8hjImf7EUQWHLnni6Iags+7NBRGguP9GoRle7zRvG9+qAX1kUy2R5pqrsnTCtQ8vzHFamy81aIA4XmLuu03ra2barmyAUiq4WU2Dln2aFwPh/Y2IETlQ3buZYt5XTRDiL8OJz377sH32rJv/tG7fsx8y2vw3QdRCNy9hyphkr0o9tGyLtfmdtyc6DwuhykEfxS7r0tbAoDq97C8o60JxXsr/uI5MzhFX9A95lc547T1vLW7SQfs09Xwo6XIYswu7g1nhzl3tck3ivucRudLykY3W+K+Dpmq0LMuYLbLIY4D0+sEyS9PpOwfnIzwPEZPPL/6Lpp7Urdd8+ViY5JyR58AKzghvaqHOBclHi+5iD/S6+RM+e+9OEDSxakWmMMqdMk91pXE+1UxWxNxxa5a7outViQ0zUJbfoppD3iouKVMldt29ViPOVm2GxMoxcM9CXq5v5QudjMQwpuMuc6Sr7H4fPa15Gr3VqUmeq+/kBXwXJ0EcQK3neB4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(83380400001)(6486002)(36756003)(8936002)(33656002)(5660300002)(2616005)(86362001)(38100700002)(478600001)(6512007)(91956017)(26005)(41300700001)(38070700005)(122000001)(30864003)(2906002)(71200400001)(186003)(6506007)(66476007)(4326008)(66556008)(8676002)(66946007)(76116006)(64756008)(316002)(110136005)(54906003)(53546011)(66446008)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g7nLZp6ArTCTKC02/lkAgAf/O6yOqIhm/9MpIHVjS9KCN4D9p54OfMd46UNv?=
 =?us-ascii?Q?am95FrvrbfbGIZ3zkd9TUPnMcnPGeoIhdUEyW3cneCyvyONkz1fS28noPLu1?=
 =?us-ascii?Q?ukkbBEPx+mGPD/zjeHsdhNWI1wqCGkmBpg7+GIb9KkOXrquipw+K6PtOq4ws?=
 =?us-ascii?Q?yMUDgubpF3Tj8B9DQhK3IqXtY0hiuaTm/k3MxEh8a982J3Pcpy6ptR58aDte?=
 =?us-ascii?Q?hLT12HIYcXnAYJjcvBQDbQujFoDyJ/kfnRdXuGCI2dUw/fDuOLP51T6EWPlx?=
 =?us-ascii?Q?RlI+SwSGYxJHMZyPRbc6JHjNsrh6KjbDziIDkvQYGROX2qBREnMDt3kpBzDi?=
 =?us-ascii?Q?9wnhtD7RTRdz5ebqAz11BA6syziUavjFdgBfNzxMcndbbajUg4GbDhXugLlI?=
 =?us-ascii?Q?eZzzWaoV/nFp4diXHW5nlJ17v7RRrTKyj/qkKWi3OU1K0vzd3hLgpHol1WNW?=
 =?us-ascii?Q?GyybMZwPrmMpeNQDkNigWCRGZOsm3uI8ahfTFRyRJSrq1th9qo6Z84PaEx5Z?=
 =?us-ascii?Q?FWX1e7yqfny6PinIrLUnL2FL7zWiOgHaYESvxmq4yaWccTXArv4GcV6R+vLx?=
 =?us-ascii?Q?2uPH0dmGNrqanhtHeQOAGrct4Yxa6buQq7bFoN/Kf/pUUNCxyEpyj9ttHz7g?=
 =?us-ascii?Q?AVAlJQt4ynwYmdMDCAVVbVARfmCo+2N6QYjGv6o3PfSwzTs0+r+FFR62djvP?=
 =?us-ascii?Q?3NyOJYxa7wESUxaCq2WPkxnENxkEmiuK8chGKZuxym2kYeMarn8E3S/rwZIL?=
 =?us-ascii?Q?d8TJ/paf0dvt5qd+Mivte4SMkIZbAfGloZu19Cj+tYjKc/pHxal0vheUnisn?=
 =?us-ascii?Q?iKSarevsI/uuLhqlOhf11SE+MOIBvXaQ0wEeZ8iEPCQZQ41msPu6dhRKF8gq?=
 =?us-ascii?Q?oUrdNOzWTWvX87rJm+tBlrJ+HUEJRuS2XaWoAgdiBEQJuLkrqUzx5SBHwN9E?=
 =?us-ascii?Q?VPJETirXlUhhTe4lFoIL1uOk6uX1WIBx6mcCJ3ePr1bsmozLt0E0C4xaUk+N?=
 =?us-ascii?Q?0k1sVPtaOJPtHbMaZRJ8tEViKrqCfrb0aqHmKIj+reOxJEwcqp7fkCbAJIWJ?=
 =?us-ascii?Q?citx+jeVJSK7nOeiSvZTCGtxJINdVh6ENBlaoCvkzxaTUd0dD9Wd8/DAcECY?=
 =?us-ascii?Q?FcY9amARkY6Zx//iy13GwnvW/w5v/f9D30QLCSmTdgkf1DrN2ZMUH+ito9VP?=
 =?us-ascii?Q?V2pGHk17NSFyBkVFXJoAknsCsbFwDCzN+Lr0TM5CoirIoRzhopKW9IdHuMaq?=
 =?us-ascii?Q?CVLgfcXvrXHQM1MAM3qy8aNSqYlQPlLn9Pv2NVmFOLCGx1xg9BjvZzFsBD0X?=
 =?us-ascii?Q?3Utz7C1hWJ88KDHYYCjf/hK93LljwJMNkAY7IlLK++lU0IVhc6nAm11PvRYK?=
 =?us-ascii?Q?Cna0GgorggMlh89B0JwzRbF7F96nZoXypmqw5P+JsYtWLjz2x6MCW07FvoiS?=
 =?us-ascii?Q?ngqVkB3nMPTxQRAEFXaooklKhRrZHQf4C4aIBFc5/nQN9YLyic3IE+qalTxX?=
 =?us-ascii?Q?yF8p7h0JsTpTe/A7/EhmyfL145UF9rEmezl6gHM47Pf0+7ZkkDia5S90MzSt?=
 =?us-ascii?Q?fhXkboGEktJvqoZMGd0/RThn0ljunCTQQ6eNozRuGlvvDx/QmNvKMqZRo9Xt?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26A831BC98B10F4A842C6266FB745D22@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sGPWG43/gZxa+wjv7eyryFDs1AjtPfFTT1z4Ee8dH9KxVhC4xutvCvjX77oKZ3riLtS2ygdUUvAl+s5Tti52O6+E19hczkq0/RLH3jIGx9zWps97vxVeiqju6FM1e9ketOjmGJsNPMOhk5B9Od1J3i6uh48QVPMJ/1T2Fkn3vnljdskfjGz3xFU3MuFTfe+rs54LJliVgv5kqxfavVqHZYDEafIFJXixi/jYCWV7RwCo4BRSHZPUIGb5WikfWv10FuxsqK1ARsxVhiktbnz9pjwozG5xdQrFHgmIoAwjav8VRUb2N5QhQ3zcfc58rBRcO+014ANhPDIVX5N4Zmof6m0LN3JzsW0jHVpFff89hyW23jdsu+jk3uDV6ZMbjSqkLCVHTk5MiIKfhPrTE4hfKKqu8ZYOUzy1i6aZ3JU3kCP9eZqOU5cEXfwMa/4agxAJseyqNksUNkPP1XydVpVIvIL9XXO2fQ8n1FCqMqdfdgq5kons51QlRlZ1GeX7VTGI3/gJ9XIyaLytB2LYmInKXoFQZKHRI/IaTb3aWlPw4SI5CVViUyKbgYXjXdyrs9Y3OEKjqmv86ncbgLFDTIdsfIyXbvh2yd8alaHvC/Gi+4lC0kKN3x61i2+TOS/ffsrL3N0u7tIKRNtv+p1lTokrJrga/B56K8+gfdLIqEg+hyZAl0aI13GM75eV0ofQnnEZQaIt8LOviGajKGaX182fkEapB7S6yc1y0iv6j/lirITSvbZj1iQtXdYblIWr7WqOMeoxTqqxQV7MkO0YDmE6NKEVMZ7PQ2cDkfkxuv3tuMnFJ1FUWeWkqAX1wOsTuG0+0KDxG6PqBT/uBwhJwn2wAqeR4kWoxc0UOGsdQf5Ahchpbfb0fOkZcODmxG5Oi7ZojWerhGTnEFmRAbfC1vyp6DdhSszKpg3aycEvi141etk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7c12c3-33fb-47ec-a7ab-08dacbd0b8dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 14:57:34.1048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKYSeiQ6wxmFU2btx3WUCU37duRDFBNufa8xSdhQrBd/TTS3xk8ne9af6A9ikcHEoWSpAZcKcw+kCfGZCGegYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210116
X-Proofpoint-GUID: ObVw_uwK6b0YcFHrjHgRSgnVKf5GimxV
X-Proofpoint-ORIG-GUID: ObVw_uwK6b0YcFHrjHgRSgnVKf5GimxV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 17, 2022, at 9:27 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> Steven Rostedt says:
>> The include/trace/events/ directory should only hold files that
>> are to create events, not headers that hold helper functions.
>>=20
>> Can you please move them out of include/trace/events/ as that
>> directory is "special" in the creation of events.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> MAINTAINERS                         |    7 +
> drivers/infiniband/core/cm_trace.h  |    2=20
> drivers/infiniband/core/cma_trace.h |    2=20
> fs/nfs/nfs4trace.h                  |    6 -
> fs/nfs/nfstrace.h                   |    6 -
> include/trace/events/fs.h           |  122 -----------
> include/trace/events/nfs.h          |  375 ------------------------------=
-----
> include/trace/events/rdma.h         |  168 ----------------
> include/trace/events/rpcgss.h       |    2=20
> include/trace/events/rpcrdma.h      |    4=20
> include/trace/events/sunrpc.h       |    2=20
> include/trace/events/sunrpc_base.h  |   18 --
> include/trace/misc/fs.h             |  122 +++++++++++
> include/trace/misc/nfs.h            |  375 ++++++++++++++++++++++++++++++=
+++++
> include/trace/misc/rdma.h           |  168 ++++++++++++++++
> include/trace/misc/sunrpc.h         |   18 ++
> 16 files changed, 702 insertions(+), 695 deletions(-)
> delete mode 100644 include/trace/events/fs.h
> delete mode 100644 include/trace/events/nfs.h
> delete mode 100644 include/trace/events/rdma.h
> delete mode 100644 include/trace/events/sunrpc_base.h
> create mode 100644 include/trace/misc/fs.h
> create mode 100644 include/trace/misc/nfs.h
> create mode 100644 include/trace/misc/rdma.h
> create mode 100644 include/trace/misc/sunrpc.h
>=20
> Note: with an Acked-by from both the NFS client and RDMA core
> maintainers I can take this through the nfsd for-next tree, unless
> someone has another suggestion.
>=20
> Still missing Acks from the NFS maintainers.

Nudge.


> Changes since v2:
> - Add Acks from Leon and Steven
> - Update MAINTAINERS for RPC-related include files
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84f7496dd950..181ae044c9f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10055,6 +10055,7 @@ F:	drivers/infiniband/
> F:	include/rdma/
> F:	include/trace/events/ib_mad.h
> F:	include/trace/events/ib_umad.h
> +F:	include/trace/misc/rdma.h
> F:	include/uapi/linux/if_infiniband.h
> F:	include/uapi/rdma/
> F:	samples/bpf/ibumad_kern.c
> @@ -11137,6 +11138,12 @@ F:	fs/nfs_common/
> F:	fs/nfsd/
> F:	include/linux/lockd/
> F:	include/linux/sunrpc/
> +F:	include/trace/events/rpcgss.h
> +F:	include/trace/events/rpcrdma.h
> +F:	include/trace/events/sunrpc.h
> +F:	include/trace/misc/fs.h
> +F:	include/trace/misc/nfs.h
> +F:	include/trace/misc/sunrpc.h
> F:	include/uapi/linux/nfsd/
> F:	include/uapi/linux/sunrpc/
> F:	net/sunrpc/
> diff --git a/drivers/infiniband/core/cm_trace.h b/drivers/infiniband/core=
/cm_trace.h
> index e9d282679ef1..944d9071245d 100644
> --- a/drivers/infiniband/core/cm_trace.h
> +++ b/drivers/infiniband/core/cm_trace.h
> @@ -16,7 +16,7 @@
>=20
> #include <linux/tracepoint.h>
> #include <rdma/ib_cm.h>
> -#include <trace/events/rdma.h>
> +#include <trace/misc/rdma.h>
>=20
> /*
>  * enum ib_cm_state, from include/rdma/ib_cm.h
> diff --git a/drivers/infiniband/core/cma_trace.h b/drivers/infiniband/cor=
e/cma_trace.h
> index e45264267bcc..47f3c6e4be89 100644
> --- a/drivers/infiniband/core/cma_trace.h
> +++ b/drivers/infiniband/core/cma_trace.h
> @@ -15,7 +15,7 @@
> #define _TRACE_RDMA_CMA_H
>=20
> #include <linux/tracepoint.h>
> -#include <trace/events/rdma.h>
> +#include <trace/misc/rdma.h>
>=20
>=20
> DECLARE_EVENT_CLASS(cma_fsm_class,
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index 2cff5901c689..633cc64a04da 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -9,10 +9,10 @@
> #define _TRACE_NFS4_H
>=20
> #include <linux/tracepoint.h>
> -#include <trace/events/sunrpc_base.h>
> +#include <trace/misc/sunrpc.h>
>=20
> -#include <trace/events/fs.h>
> -#include <trace/events/nfs.h>
> +#include <trace/misc/fs.h>
> +#include <trace/misc/nfs.h>
>=20
> #define show_nfs_fattr_flags(valid) \
> 	__print_flags((unsigned long)valid, "|", \
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 8c6cc58679ff..642f6921852f 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -11,9 +11,9 @@
> #include <linux/tracepoint.h>
> #include <linux/iversion.h>
>=20
> -#include <trace/events/fs.h>
> -#include <trace/events/nfs.h>
> -#include <trace/events/sunrpc_base.h>
> +#include <trace/misc/fs.h>
> +#include <trace/misc/nfs.h>
> +#include <trace/misc/sunrpc.h>
>=20
> #define nfs_show_cache_validity(v) \
> 	__print_flags(v, "|", \
> diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
> deleted file mode 100644
> index 738b97f22f36..000000000000
> --- a/include/trace/events/fs.h
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Display helpers for generic filesystem items
> - *
> - * Author: Chuck Lever <chuck.lever@oracle.com>
> - *
> - * Copyright (c) 2020, Oracle and/or its affiliates.
> - */
> -
> -#include <linux/fs.h>
> -
> -#define show_fs_dirent_type(x) \
> -	__print_symbolic(x, \
> -		{ DT_UNKNOWN,		"UNKNOWN" }, \
> -		{ DT_FIFO,		"FIFO" }, \
> -		{ DT_CHR,		"CHR" }, \
> -		{ DT_DIR,		"DIR" }, \
> -		{ DT_BLK,		"BLK" }, \
> -		{ DT_REG,		"REG" }, \
> -		{ DT_LNK,		"LNK" }, \
> -		{ DT_SOCK,		"SOCK" }, \
> -		{ DT_WHT,		"WHT" })
> -
> -#define show_fs_fcntl_open_flags(x) \
> -	__print_flags(x, "|", \
> -		{ O_WRONLY,		"O_WRONLY" }, \
> -		{ O_RDWR,		"O_RDWR" }, \
> -		{ O_CREAT,		"O_CREAT" }, \
> -		{ O_EXCL,		"O_EXCL" }, \
> -		{ O_NOCTTY,		"O_NOCTTY" }, \
> -		{ O_TRUNC,		"O_TRUNC" }, \
> -		{ O_APPEND,		"O_APPEND" }, \
> -		{ O_NONBLOCK,		"O_NONBLOCK" }, \
> -		{ O_DSYNC,		"O_DSYNC" }, \
> -		{ O_DIRECT,		"O_DIRECT" }, \
> -		{ O_LARGEFILE,		"O_LARGEFILE" }, \
> -		{ O_DIRECTORY,		"O_DIRECTORY" }, \
> -		{ O_NOFOLLOW,		"O_NOFOLLOW" }, \
> -		{ O_NOATIME,		"O_NOATIME" }, \
> -		{ O_CLOEXEC,		"O_CLOEXEC" })
> -
> -#define __fmode_flag(x)	{ (__force unsigned long)FMODE_##x, #x }
> -#define show_fs_fmode_flags(x) \
> -	__print_flags(x, "|", \
> -		__fmode_flag(READ), \
> -		__fmode_flag(WRITE), \
> -		__fmode_flag(EXEC))
> -
> -#ifdef CONFIG_64BIT
> -#define show_fs_fcntl_cmd(x) \
> -	__print_symbolic(x, \
> -		{ F_DUPFD,		"DUPFD" }, \
> -		{ F_GETFD,		"GETFD" }, \
> -		{ F_SETFD,		"SETFD" }, \
> -		{ F_GETFL,		"GETFL" }, \
> -		{ F_SETFL,		"SETFL" }, \
> -		{ F_GETLK,		"GETLK" }, \
> -		{ F_SETLK,		"SETLK" }, \
> -		{ F_SETLKW,		"SETLKW" }, \
> -		{ F_SETOWN,		"SETOWN" }, \
> -		{ F_GETOWN,		"GETOWN" }, \
> -		{ F_SETSIG,		"SETSIG" }, \
> -		{ F_GETSIG,		"GETSIG" }, \
> -		{ F_SETOWN_EX,		"SETOWN_EX" }, \
> -		{ F_GETOWN_EX,		"GETOWN_EX" }, \
> -		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
> -		{ F_OFD_GETLK,		"OFD_GETLK" }, \
> -		{ F_OFD_SETLK,		"OFD_SETLK" }, \
> -		{ F_OFD_SETLKW,		"OFD_SETLKW" })
> -#else /* CONFIG_64BIT */
> -#define show_fs_fcntl_cmd(x) \
> -	__print_symbolic(x, \
> -		{ F_DUPFD,		"DUPFD" }, \
> -		{ F_GETFD,		"GETFD" }, \
> -		{ F_SETFD,		"SETFD" }, \
> -		{ F_GETFL,		"GETFL" }, \
> -		{ F_SETFL,		"SETFL" }, \
> -		{ F_GETLK,		"GETLK" }, \
> -		{ F_SETLK,		"SETLK" }, \
> -		{ F_SETLKW,		"SETLKW" }, \
> -		{ F_SETOWN,		"SETOWN" }, \
> -		{ F_GETOWN,		"GETOWN" }, \
> -		{ F_SETSIG,		"SETSIG" }, \
> -		{ F_GETSIG,		"GETSIG" }, \
> -		{ F_GETLK64,		"GETLK64" }, \
> -		{ F_SETLK64,		"SETLK64" }, \
> -		{ F_SETLKW64,		"SETLKW64" }, \
> -		{ F_SETOWN_EX,		"SETOWN_EX" }, \
> -		{ F_GETOWN_EX,		"GETOWN_EX" }, \
> -		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
> -		{ F_OFD_GETLK,		"OFD_GETLK" }, \
> -		{ F_OFD_SETLK,		"OFD_SETLK" }, \
> -		{ F_OFD_SETLKW,		"OFD_SETLKW" })
> -#endif /* CONFIG_64BIT */
> -
> -#define show_fs_fcntl_lock_type(x) \
> -	__print_symbolic(x, \
> -		{ F_RDLCK,		"RDLCK" }, \
> -		{ F_WRLCK,		"WRLCK" }, \
> -		{ F_UNLCK,		"UNLCK" })
> -
> -#define show_fs_lookup_flags(flags) \
> -	__print_flags(flags, "|", \
> -		{ LOOKUP_FOLLOW,	"FOLLOW" }, \
> -		{ LOOKUP_DIRECTORY,	"DIRECTORY" }, \
> -		{ LOOKUP_AUTOMOUNT,	"AUTOMOUNT" }, \
> -		{ LOOKUP_EMPTY,		"EMPTY" }, \
> -		{ LOOKUP_DOWN,		"DOWN" }, \
> -		{ LOOKUP_MOUNTPOINT,	"MOUNTPOINT" }, \
> -		{ LOOKUP_REVAL,		"REVAL" }, \
> -		{ LOOKUP_RCU,		"RCU" }, \
> -		{ LOOKUP_OPEN,		"OPEN" }, \
> -		{ LOOKUP_CREATE,	"CREATE" }, \
> -		{ LOOKUP_EXCL,		"EXCL" }, \
> -		{ LOOKUP_RENAME_TARGET,	"RENAME_TARGET" }, \
> -		{ LOOKUP_PARENT,	"PARENT" }, \
> -		{ LOOKUP_NO_SYMLINKS,	"NO_SYMLINKS" }, \
> -		{ LOOKUP_NO_MAGICLINKS,	"NO_MAGICLINKS" }, \
> -		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
> -		{ LOOKUP_BENEATH,	"BENEATH" }, \
> -		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
> -		{ LOOKUP_CACHED,	"CACHED" })
> diff --git a/include/trace/events/nfs.h b/include/trace/events/nfs.h
> deleted file mode 100644
> index 09ffdbb04134..000000000000
> --- a/include/trace/events/nfs.h
> +++ /dev/null
> @@ -1,375 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Display helpers for NFS protocol elements
> - *
> - * Author: Chuck Lever <chuck.lever@oracle.com>
> - *
> - * Copyright (c) 2020, Oracle and/or its affiliates.
> - */
> -
> -#include <linux/nfs.h>
> -#include <linux/nfs4.h>
> -#include <uapi/linux/nfs.h>
> -
> -TRACE_DEFINE_ENUM(NFS_OK);
> -TRACE_DEFINE_ENUM(NFSERR_PERM);
> -TRACE_DEFINE_ENUM(NFSERR_NOENT);
> -TRACE_DEFINE_ENUM(NFSERR_IO);
> -TRACE_DEFINE_ENUM(NFSERR_NXIO);
> -TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
> -TRACE_DEFINE_ENUM(NFSERR_ACCES);
> -TRACE_DEFINE_ENUM(NFSERR_EXIST);
> -TRACE_DEFINE_ENUM(NFSERR_XDEV);
> -TRACE_DEFINE_ENUM(NFSERR_NODEV);
> -TRACE_DEFINE_ENUM(NFSERR_NOTDIR);
> -TRACE_DEFINE_ENUM(NFSERR_ISDIR);
> -TRACE_DEFINE_ENUM(NFSERR_INVAL);
> -TRACE_DEFINE_ENUM(NFSERR_FBIG);
> -TRACE_DEFINE_ENUM(NFSERR_NOSPC);
> -TRACE_DEFINE_ENUM(NFSERR_ROFS);
> -TRACE_DEFINE_ENUM(NFSERR_MLINK);
> -TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
> -TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
> -TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
> -TRACE_DEFINE_ENUM(NFSERR_DQUOT);
> -TRACE_DEFINE_ENUM(NFSERR_STALE);
> -TRACE_DEFINE_ENUM(NFSERR_REMOTE);
> -TRACE_DEFINE_ENUM(NFSERR_WFLUSH);
> -TRACE_DEFINE_ENUM(NFSERR_BADHANDLE);
> -TRACE_DEFINE_ENUM(NFSERR_NOT_SYNC);
> -TRACE_DEFINE_ENUM(NFSERR_BAD_COOKIE);
> -TRACE_DEFINE_ENUM(NFSERR_NOTSUPP);
> -TRACE_DEFINE_ENUM(NFSERR_TOOSMALL);
> -TRACE_DEFINE_ENUM(NFSERR_SERVERFAULT);
> -TRACE_DEFINE_ENUM(NFSERR_BADTYPE);
> -TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
> -
> -#define show_nfs_status(x) \
> -	__print_symbolic(x, \
> -		{ NFS_OK,			"OK" }, \
> -		{ NFSERR_PERM,			"PERM" }, \
> -		{ NFSERR_NOENT,			"NOENT" }, \
> -		{ NFSERR_IO,			"IO" }, \
> -		{ NFSERR_NXIO,			"NXIO" }, \
> -		{ ECHILD,			"CHILD" }, \
> -		{ NFSERR_EAGAIN,		"AGAIN" }, \
> -		{ NFSERR_ACCES,			"ACCES" }, \
> -		{ NFSERR_EXIST,			"EXIST" }, \
> -		{ NFSERR_XDEV,			"XDEV" }, \
> -		{ NFSERR_NODEV,			"NODEV" }, \
> -		{ NFSERR_NOTDIR,		"NOTDIR" }, \
> -		{ NFSERR_ISDIR,			"ISDIR" }, \
> -		{ NFSERR_INVAL,			"INVAL" }, \
> -		{ NFSERR_FBIG,			"FBIG" }, \
> -		{ NFSERR_NOSPC,			"NOSPC" }, \
> -		{ NFSERR_ROFS,			"ROFS" }, \
> -		{ NFSERR_MLINK,			"MLINK" }, \
> -		{ NFSERR_OPNOTSUPP,		"OPNOTSUPP" }, \
> -		{ NFSERR_NAMETOOLONG,		"NAMETOOLONG" }, \
> -		{ NFSERR_NOTEMPTY,		"NOTEMPTY" }, \
> -		{ NFSERR_DQUOT,			"DQUOT" }, \
> -		{ NFSERR_STALE,			"STALE" }, \
> -		{ NFSERR_REMOTE,		"REMOTE" }, \
> -		{ NFSERR_WFLUSH,		"WFLUSH" }, \
> -		{ NFSERR_BADHANDLE,		"BADHANDLE" }, \
> -		{ NFSERR_NOT_SYNC,		"NOTSYNC" }, \
> -		{ NFSERR_BAD_COOKIE,		"BADCOOKIE" }, \
> -		{ NFSERR_NOTSUPP,		"NOTSUPP" }, \
> -		{ NFSERR_TOOSMALL,		"TOOSMALL" }, \
> -		{ NFSERR_SERVERFAULT,		"REMOTEIO" }, \
> -		{ NFSERR_BADTYPE,		"BADTYPE" }, \
> -		{ NFSERR_JUKEBOX,		"JUKEBOX" })
> -
> -TRACE_DEFINE_ENUM(NFS_UNSTABLE);
> -TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
> -TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
> -
> -#define show_nfs_stable_how(x) \
> -	__print_symbolic(x, \
> -		{ NFS_UNSTABLE,			"UNSTABLE" }, \
> -		{ NFS_DATA_SYNC,		"DATA_SYNC" }, \
> -		{ NFS_FILE_SYNC,		"FILE_SYNC" })
> -
> -TRACE_DEFINE_ENUM(NFS4_OK);
> -TRACE_DEFINE_ENUM(NFS4ERR_ACCESS);
> -TRACE_DEFINE_ENUM(NFS4ERR_ATTRNOTSUPP);
> -TRACE_DEFINE_ENUM(NFS4ERR_ADMIN_REVOKED);
> -TRACE_DEFINE_ENUM(NFS4ERR_BACK_CHAN_BUSY);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADCHAR);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADHANDLE);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADIOMODE);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADLAYOUT);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADLABEL);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADNAME);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADOWNER);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADSESSION);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADSLOT);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADTYPE);
> -TRACE_DEFINE_ENUM(NFS4ERR_BADXDR);
> -TRACE_DEFINE_ENUM(NFS4ERR_BAD_COOKIE);
> -TRACE_DEFINE_ENUM(NFS4ERR_BAD_HIGH_SLOT);
> -TRACE_DEFINE_ENUM(NFS4ERR_BAD_RANGE);
> -TRACE_DEFINE_ENUM(NFS4ERR_BAD_SEQID);
> -TRACE_DEFINE_ENUM(NFS4ERR_BAD_SESSION_DIGEST);
> -TRACE_DEFINE_ENUM(NFS4ERR_BAD_STATEID);
> -TRACE_DEFINE_ENUM(NFS4ERR_CB_PATH_DOWN);
> -TRACE_DEFINE_ENUM(NFS4ERR_CLID_INUSE);
> -TRACE_DEFINE_ENUM(NFS4ERR_CLIENTID_BUSY);
> -TRACE_DEFINE_ENUM(NFS4ERR_COMPLETE_ALREADY);
> -TRACE_DEFINE_ENUM(NFS4ERR_CONN_NOT_BOUND_TO_SESSION);
> -TRACE_DEFINE_ENUM(NFS4ERR_DEADLOCK);
> -TRACE_DEFINE_ENUM(NFS4ERR_DEADSESSION);
> -TRACE_DEFINE_ENUM(NFS4ERR_DELAY);
> -TRACE_DEFINE_ENUM(NFS4ERR_DELEG_ALREADY_WANTED);
> -TRACE_DEFINE_ENUM(NFS4ERR_DELEG_REVOKED);
> -TRACE_DEFINE_ENUM(NFS4ERR_DENIED);
> -TRACE_DEFINE_ENUM(NFS4ERR_DIRDELEG_UNAVAIL);
> -TRACE_DEFINE_ENUM(NFS4ERR_DQUOT);
> -TRACE_DEFINE_ENUM(NFS4ERR_ENCR_ALG_UNSUPP);
> -TRACE_DEFINE_ENUM(NFS4ERR_EXIST);
> -TRACE_DEFINE_ENUM(NFS4ERR_EXPIRED);
> -TRACE_DEFINE_ENUM(NFS4ERR_FBIG);
> -TRACE_DEFINE_ENUM(NFS4ERR_FHEXPIRED);
> -TRACE_DEFINE_ENUM(NFS4ERR_FILE_OPEN);
> -TRACE_DEFINE_ENUM(NFS4ERR_GRACE);
> -TRACE_DEFINE_ENUM(NFS4ERR_HASH_ALG_UNSUPP);
> -TRACE_DEFINE_ENUM(NFS4ERR_INVAL);
> -TRACE_DEFINE_ENUM(NFS4ERR_IO);
> -TRACE_DEFINE_ENUM(NFS4ERR_ISDIR);
> -TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTTRYLATER);
> -TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTUNAVAILABLE);
> -TRACE_DEFINE_ENUM(NFS4ERR_LEASE_MOVED);
> -TRACE_DEFINE_ENUM(NFS4ERR_LOCKED);
> -TRACE_DEFINE_ENUM(NFS4ERR_LOCKS_HELD);
> -TRACE_DEFINE_ENUM(NFS4ERR_LOCK_RANGE);
> -TRACE_DEFINE_ENUM(NFS4ERR_MINOR_VERS_MISMATCH);
> -TRACE_DEFINE_ENUM(NFS4ERR_MLINK);
> -TRACE_DEFINE_ENUM(NFS4ERR_MOVED);
> -TRACE_DEFINE_ENUM(NFS4ERR_NAMETOOLONG);
> -TRACE_DEFINE_ENUM(NFS4ERR_NOENT);
> -TRACE_DEFINE_ENUM(NFS4ERR_NOFILEHANDLE);
> -TRACE_DEFINE_ENUM(NFS4ERR_NOMATCHING_LAYOUT);
> -TRACE_DEFINE_ENUM(NFS4ERR_NOSPC);
> -TRACE_DEFINE_ENUM(NFS4ERR_NOTDIR);
> -TRACE_DEFINE_ENUM(NFS4ERR_NOTEMPTY);
> -TRACE_DEFINE_ENUM(NFS4ERR_NOTSUPP);
> -TRACE_DEFINE_ENUM(NFS4ERR_NOT_ONLY_OP);
> -TRACE_DEFINE_ENUM(NFS4ERR_NOT_SAME);
> -TRACE_DEFINE_ENUM(NFS4ERR_NO_GRACE);
> -TRACE_DEFINE_ENUM(NFS4ERR_NXIO);
> -TRACE_DEFINE_ENUM(NFS4ERR_OLD_STATEID);
> -TRACE_DEFINE_ENUM(NFS4ERR_OPENMODE);
> -TRACE_DEFINE_ENUM(NFS4ERR_OP_ILLEGAL);
> -TRACE_DEFINE_ENUM(NFS4ERR_OP_NOT_IN_SESSION);
> -TRACE_DEFINE_ENUM(NFS4ERR_PERM);
> -TRACE_DEFINE_ENUM(NFS4ERR_PNFS_IO_HOLE);
> -TRACE_DEFINE_ENUM(NFS4ERR_PNFS_NO_LAYOUT);
> -TRACE_DEFINE_ENUM(NFS4ERR_RECALLCONFLICT);
> -TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_BAD);
> -TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_CONFLICT);
> -TRACE_DEFINE_ENUM(NFS4ERR_REJECT_DELEG);
> -TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG);
> -TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG_TO_CACHE);
> -TRACE_DEFINE_ENUM(NFS4ERR_REQ_TOO_BIG);
> -TRACE_DEFINE_ENUM(NFS4ERR_RESOURCE);
> -TRACE_DEFINE_ENUM(NFS4ERR_RESTOREFH);
> -TRACE_DEFINE_ENUM(NFS4ERR_RETRY_UNCACHED_REP);
> -TRACE_DEFINE_ENUM(NFS4ERR_RETURNCONFLICT);
> -TRACE_DEFINE_ENUM(NFS4ERR_ROFS);
> -TRACE_DEFINE_ENUM(NFS4ERR_SAME);
> -TRACE_DEFINE_ENUM(NFS4ERR_SHARE_DENIED);
> -TRACE_DEFINE_ENUM(NFS4ERR_SEQUENCE_POS);
> -TRACE_DEFINE_ENUM(NFS4ERR_SEQ_FALSE_RETRY);
> -TRACE_DEFINE_ENUM(NFS4ERR_SEQ_MISORDERED);
> -TRACE_DEFINE_ENUM(NFS4ERR_SERVERFAULT);
> -TRACE_DEFINE_ENUM(NFS4ERR_STALE);
> -TRACE_DEFINE_ENUM(NFS4ERR_STALE_CLIENTID);
> -TRACE_DEFINE_ENUM(NFS4ERR_STALE_STATEID);
> -TRACE_DEFINE_ENUM(NFS4ERR_SYMLINK);
> -TRACE_DEFINE_ENUM(NFS4ERR_TOOSMALL);
> -TRACE_DEFINE_ENUM(NFS4ERR_TOO_MANY_OPS);
> -TRACE_DEFINE_ENUM(NFS4ERR_UNKNOWN_LAYOUTTYPE);
> -TRACE_DEFINE_ENUM(NFS4ERR_UNSAFE_COMPOUND);
> -TRACE_DEFINE_ENUM(NFS4ERR_WRONGSEC);
> -TRACE_DEFINE_ENUM(NFS4ERR_WRONG_CRED);
> -TRACE_DEFINE_ENUM(NFS4ERR_WRONG_TYPE);
> -TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
> -
> -TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_MDS);
> -TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
> -
> -#define show_nfs4_status(x) \
> -	__print_symbolic(x, \
> -		{ NFS4_OK,			"OK" }, \
> -		{ EPERM,			"EPERM" }, \
> -		{ ENOENT,			"ENOENT" }, \
> -		{ EIO,				"EIO" }, \
> -		{ ENXIO,			"ENXIO" }, \
> -		{ EACCES,			"EACCES" }, \
> -		{ EEXIST,			"EEXIST" }, \
> -		{ EXDEV,			"EXDEV" }, \
> -		{ ENOTDIR,			"ENOTDIR" }, \
> -		{ EISDIR,			"EISDIR" }, \
> -		{ EFBIG,			"EFBIG" }, \
> -		{ ENOSPC,			"ENOSPC" }, \
> -		{ EROFS,			"EROFS" }, \
> -		{ EMLINK,			"EMLINK" }, \
> -		{ ENAMETOOLONG,			"ENAMETOOLONG" }, \
> -		{ ENOTEMPTY,			"ENOTEMPTY" }, \
> -		{ EDQUOT,			"EDQUOT" }, \
> -		{ ESTALE,			"ESTALE" }, \
> -		{ EBADHANDLE,			"EBADHANDLE" }, \
> -		{ EBADCOOKIE,			"EBADCOOKIE" }, \
> -		{ ENOTSUPP,			"ENOTSUPP" }, \
> -		{ ETOOSMALL,			"ETOOSMALL" }, \
> -		{ EREMOTEIO,			"EREMOTEIO" }, \
> -		{ EBADTYPE,			"EBADTYPE" }, \
> -		{ EAGAIN,			"EAGAIN" }, \
> -		{ ELOOP,			"ELOOP" }, \
> -		{ EOPNOTSUPP,			"EOPNOTSUPP" }, \
> -		{ EDEADLK,			"EDEADLK" }, \
> -		{ ENOMEM,			"ENOMEM" }, \
> -		{ EKEYEXPIRED,			"EKEYEXPIRED" }, \
> -		{ ETIMEDOUT,			"ETIMEDOUT" }, \
> -		{ ERESTARTSYS,			"ERESTARTSYS" }, \
> -		{ ECONNREFUSED,			"ECONNREFUSED" }, \
> -		{ ECONNRESET,			"ECONNRESET" }, \
> -		{ ENETUNREACH,			"ENETUNREACH" }, \
> -		{ EHOSTUNREACH,			"EHOSTUNREACH" }, \
> -		{ EHOSTDOWN,			"EHOSTDOWN" }, \
> -		{ EPIPE,			"EPIPE" }, \
> -		{ EPFNOSUPPORT,			"EPFNOSUPPORT" }, \
> -		{ EPROTONOSUPPORT,		"EPROTONOSUPPORT" }, \
> -		{ NFS4ERR_ACCESS,		"ACCESS" }, \
> -		{ NFS4ERR_ATTRNOTSUPP,		"ATTRNOTSUPP" }, \
> -		{ NFS4ERR_ADMIN_REVOKED,	"ADMIN_REVOKED" }, \
> -		{ NFS4ERR_BACK_CHAN_BUSY,	"BACK_CHAN_BUSY" }, \
> -		{ NFS4ERR_BADCHAR,		"BADCHAR" }, \
> -		{ NFS4ERR_BADHANDLE,		"BADHANDLE" }, \
> -		{ NFS4ERR_BADIOMODE,		"BADIOMODE" }, \
> -		{ NFS4ERR_BADLAYOUT,		"BADLAYOUT" }, \
> -		{ NFS4ERR_BADLABEL,		"BADLABEL" }, \
> -		{ NFS4ERR_BADNAME,		"BADNAME" }, \
> -		{ NFS4ERR_BADOWNER,		"BADOWNER" }, \
> -		{ NFS4ERR_BADSESSION,		"BADSESSION" }, \
> -		{ NFS4ERR_BADSLOT,		"BADSLOT" }, \
> -		{ NFS4ERR_BADTYPE,		"BADTYPE" }, \
> -		{ NFS4ERR_BADXDR,		"BADXDR" }, \
> -		{ NFS4ERR_BAD_COOKIE,		"BAD_COOKIE" }, \
> -		{ NFS4ERR_BAD_HIGH_SLOT,	"BAD_HIGH_SLOT" }, \
> -		{ NFS4ERR_BAD_RANGE,		"BAD_RANGE" }, \
> -		{ NFS4ERR_BAD_SEQID,		"BAD_SEQID" }, \
> -		{ NFS4ERR_BAD_SESSION_DIGEST,	"BAD_SESSION_DIGEST" }, \
> -		{ NFS4ERR_BAD_STATEID,		"BAD_STATEID" }, \
> -		{ NFS4ERR_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
> -		{ NFS4ERR_CLID_INUSE,		"CLID_INUSE" }, \
> -		{ NFS4ERR_CLIENTID_BUSY,	"CLIENTID_BUSY" }, \
> -		{ NFS4ERR_COMPLETE_ALREADY,	"COMPLETE_ALREADY" }, \
> -		{ NFS4ERR_CONN_NOT_BOUND_TO_SESSION, "CONN_NOT_BOUND_TO_SESSION" }, \
> -		{ NFS4ERR_DEADLOCK,		"DEADLOCK" }, \
> -		{ NFS4ERR_DEADSESSION,		"DEAD_SESSION" }, \
> -		{ NFS4ERR_DELAY,		"DELAY" }, \
> -		{ NFS4ERR_DELEG_ALREADY_WANTED,	"DELEG_ALREADY_WANTED" }, \
> -		{ NFS4ERR_DELEG_REVOKED,	"DELEG_REVOKED" }, \
> -		{ NFS4ERR_DENIED,		"DENIED" }, \
> -		{ NFS4ERR_DIRDELEG_UNAVAIL,	"DIRDELEG_UNAVAIL" }, \
> -		{ NFS4ERR_DQUOT,		"DQUOT" }, \
> -		{ NFS4ERR_ENCR_ALG_UNSUPP,	"ENCR_ALG_UNSUPP" }, \
> -		{ NFS4ERR_EXIST,		"EXIST" }, \
> -		{ NFS4ERR_EXPIRED,		"EXPIRED" }, \
> -		{ NFS4ERR_FBIG,			"FBIG" }, \
> -		{ NFS4ERR_FHEXPIRED,		"FHEXPIRED" }, \
> -		{ NFS4ERR_FILE_OPEN,		"FILE_OPEN" }, \
> -		{ NFS4ERR_GRACE,		"GRACE" }, \
> -		{ NFS4ERR_HASH_ALG_UNSUPP,	"HASH_ALG_UNSUPP" }, \
> -		{ NFS4ERR_INVAL,		"INVAL" }, \
> -		{ NFS4ERR_IO,			"IO" }, \
> -		{ NFS4ERR_ISDIR,		"ISDIR" }, \
> -		{ NFS4ERR_LAYOUTTRYLATER,	"LAYOUTTRYLATER" }, \
> -		{ NFS4ERR_LAYOUTUNAVAILABLE,	"LAYOUTUNAVAILABLE" }, \
> -		{ NFS4ERR_LEASE_MOVED,		"LEASE_MOVED" }, \
> -		{ NFS4ERR_LOCKED,		"LOCKED" }, \
> -		{ NFS4ERR_LOCKS_HELD,		"LOCKS_HELD" }, \
> -		{ NFS4ERR_LOCK_RANGE,		"LOCK_RANGE" }, \
> -		{ NFS4ERR_MINOR_VERS_MISMATCH,	"MINOR_VERS_MISMATCH" }, \
> -		{ NFS4ERR_MLINK,		"MLINK" }, \
> -		{ NFS4ERR_MOVED,		"MOVED" }, \
> -		{ NFS4ERR_NAMETOOLONG,		"NAMETOOLONG" }, \
> -		{ NFS4ERR_NOENT,		"NOENT" }, \
> -		{ NFS4ERR_NOFILEHANDLE,		"NOFILEHANDLE" }, \
> -		{ NFS4ERR_NOMATCHING_LAYOUT,	"NOMATCHING_LAYOUT" }, \
> -		{ NFS4ERR_NOSPC,		"NOSPC" }, \
> -		{ NFS4ERR_NOTDIR,		"NOTDIR" }, \
> -		{ NFS4ERR_NOTEMPTY,		"NOTEMPTY" }, \
> -		{ NFS4ERR_NOTSUPP,		"NOTSUPP" }, \
> -		{ NFS4ERR_NOT_ONLY_OP,		"NOT_ONLY_OP" }, \
> -		{ NFS4ERR_NOT_SAME,		"NOT_SAME" }, \
> -		{ NFS4ERR_NO_GRACE,		"NO_GRACE" }, \
> -		{ NFS4ERR_NXIO,			"NXIO" }, \
> -		{ NFS4ERR_OLD_STATEID,		"OLD_STATEID" }, \
> -		{ NFS4ERR_OPENMODE,		"OPENMODE" }, \
> -		{ NFS4ERR_OP_ILLEGAL,		"OP_ILLEGAL" }, \
> -		{ NFS4ERR_OP_NOT_IN_SESSION,	"OP_NOT_IN_SESSION" }, \
> -		{ NFS4ERR_PERM,			"PERM" }, \
> -		{ NFS4ERR_PNFS_IO_HOLE,		"PNFS_IO_HOLE" }, \
> -		{ NFS4ERR_PNFS_NO_LAYOUT,	"PNFS_NO_LAYOUT" }, \
> -		{ NFS4ERR_RECALLCONFLICT,	"RECALLCONFLICT" }, \
> -		{ NFS4ERR_RECLAIM_BAD,		"RECLAIM_BAD" }, \
> -		{ NFS4ERR_RECLAIM_CONFLICT,	"RECLAIM_CONFLICT" }, \
> -		{ NFS4ERR_REJECT_DELEG,		"REJECT_DELEG" }, \
> -		{ NFS4ERR_REP_TOO_BIG,		"REP_TOO_BIG" }, \
> -		{ NFS4ERR_REP_TOO_BIG_TO_CACHE,	"REP_TOO_BIG_TO_CACHE" }, \
> -		{ NFS4ERR_REQ_TOO_BIG,		"REQ_TOO_BIG" }, \
> -		{ NFS4ERR_RESOURCE,		"RESOURCE" }, \
> -		{ NFS4ERR_RESTOREFH,		"RESTOREFH" }, \
> -		{ NFS4ERR_RETRY_UNCACHED_REP,	"RETRY_UNCACHED_REP" }, \
> -		{ NFS4ERR_RETURNCONFLICT,	"RETURNCONFLICT" }, \
> -		{ NFS4ERR_ROFS,			"ROFS" }, \
> -		{ NFS4ERR_SAME,			"SAME" }, \
> -		{ NFS4ERR_SHARE_DENIED,		"SHARE_DENIED" }, \
> -		{ NFS4ERR_SEQUENCE_POS,		"SEQUENCE_POS" }, \
> -		{ NFS4ERR_SEQ_FALSE_RETRY,	"SEQ_FALSE_RETRY" }, \
> -		{ NFS4ERR_SEQ_MISORDERED,	"SEQ_MISORDERED" }, \
> -		{ NFS4ERR_SERVERFAULT,		"SERVERFAULT" }, \
> -		{ NFS4ERR_STALE,		"STALE" }, \
> -		{ NFS4ERR_STALE_CLIENTID,	"STALE_CLIENTID" }, \
> -		{ NFS4ERR_STALE_STATEID,	"STALE_STATEID" }, \
> -		{ NFS4ERR_SYMLINK,		"SYMLINK" }, \
> -		{ NFS4ERR_TOOSMALL,		"TOOSMALL" }, \
> -		{ NFS4ERR_TOO_MANY_OPS,		"TOO_MANY_OPS" }, \
> -		{ NFS4ERR_UNKNOWN_LAYOUTTYPE,	"UNKNOWN_LAYOUTTYPE" }, \
> -		{ NFS4ERR_UNSAFE_COMPOUND,	"UNSAFE_COMPOUND" }, \
> -		{ NFS4ERR_WRONGSEC,		"WRONGSEC" }, \
> -		{ NFS4ERR_WRONG_CRED,		"WRONG_CRED" }, \
> -		{ NFS4ERR_WRONG_TYPE,		"WRONG_TYPE" }, \
> -		{ NFS4ERR_XDEV,			"XDEV" }, \
> -		/* ***** Internal to Linux NFS client ***** */ \
> -		{ NFS4ERR_RESET_TO_MDS,		"RESET_TO_MDS" }, \
> -		{ NFS4ERR_RESET_TO_PNFS,	"RESET_TO_PNFS" })
> -
> -#define show_nfs4_verifier(x) \
> -	__print_hex_str(x, NFS4_VERIFIER_SIZE)
> -
> -TRACE_DEFINE_ENUM(IOMODE_READ);
> -TRACE_DEFINE_ENUM(IOMODE_RW);
> -TRACE_DEFINE_ENUM(IOMODE_ANY);
> -
> -#define show_pnfs_layout_iomode(x) \
> -	__print_symbolic(x, \
> -		{ IOMODE_READ,			"READ" }, \
> -		{ IOMODE_RW,			"RW" }, \
> -		{ IOMODE_ANY,			"ANY" })
> -
> -#define show_nfs4_seq4_status(x) \
> -	__print_flags(x, "|", \
> -		{ SEQ4_STATUS_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
> -		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING,	"CB_GSS_CONTEXTS_EXPIRING" }, =
\
> -		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED,	"CB_GSS_CONTEXTS_EXPIRED" }, \
> -		{ SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED, "EXPIRED_ALL_STATE_REVOKED" }=
, \
> -		{ SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED, "EXPIRED_SOME_STATE_REVOKED"=
 }, \
> -		{ SEQ4_STATUS_ADMIN_STATE_REVOKED,	"ADMIN_STATE_REVOKED" }, \
> -		{ SEQ4_STATUS_RECALLABLE_STATE_REVOKED,	"RECALLABLE_STATE_REVOKED" }, =
\
> -		{ SEQ4_STATUS_LEASE_MOVED,		"LEASE_MOVED" }, \
> -		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED,	"RESTART_RECLAIM_NEEDED" }, \
> -		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION,	"CB_PATH_DOWN_SESSION" }, \
> -		{ SEQ4_STATUS_BACKCHANNEL_FAULT,	"BACKCHANNEL_FAULT" })
> diff --git a/include/trace/events/rdma.h b/include/trace/events/rdma.h
> deleted file mode 100644
> index 81bb454fc288..000000000000
> --- a/include/trace/events/rdma.h
> +++ /dev/null
> @@ -1,168 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (c) 2017 Oracle.  All rights reserved.
> - */
> -
> -/*
> - * enum ib_event_type, from include/rdma/ib_verbs.h
> - */
> -#define IB_EVENT_LIST				\
> -	ib_event(CQ_ERR)			\
> -	ib_event(QP_FATAL)			\
> -	ib_event(QP_REQ_ERR)			\
> -	ib_event(QP_ACCESS_ERR)			\
> -	ib_event(COMM_EST)			\
> -	ib_event(SQ_DRAINED)			\
> -	ib_event(PATH_MIG)			\
> -	ib_event(PATH_MIG_ERR)			\
> -	ib_event(DEVICE_FATAL)			\
> -	ib_event(PORT_ACTIVE)			\
> -	ib_event(PORT_ERR)			\
> -	ib_event(LID_CHANGE)			\
> -	ib_event(PKEY_CHANGE)			\
> -	ib_event(SM_CHANGE)			\
> -	ib_event(SRQ_ERR)			\
> -	ib_event(SRQ_LIMIT_REACHED)		\
> -	ib_event(QP_LAST_WQE_REACHED)		\
> -	ib_event(CLIENT_REREGISTER)		\
> -	ib_event(GID_CHANGE)			\
> -	ib_event_end(WQ_FATAL)
> -
> -#undef ib_event
> -#undef ib_event_end
> -
> -#define ib_event(x)		TRACE_DEFINE_ENUM(IB_EVENT_##x);
> -#define ib_event_end(x)		TRACE_DEFINE_ENUM(IB_EVENT_##x);
> -
> -IB_EVENT_LIST
> -
> -#undef ib_event
> -#undef ib_event_end
> -
> -#define ib_event(x)		{ IB_EVENT_##x, #x },
> -#define ib_event_end(x)		{ IB_EVENT_##x, #x }
> -
> -#define rdma_show_ib_event(x) \
> -		__print_symbolic(x, IB_EVENT_LIST)
> -
> -/*
> - * enum ib_wc_status type, from include/rdma/ib_verbs.h
> - */
> -#define IB_WC_STATUS_LIST			\
> -	ib_wc_status(SUCCESS)			\
> -	ib_wc_status(LOC_LEN_ERR)		\
> -	ib_wc_status(LOC_QP_OP_ERR)		\
> -	ib_wc_status(LOC_EEC_OP_ERR)		\
> -	ib_wc_status(LOC_PROT_ERR)		\
> -	ib_wc_status(WR_FLUSH_ERR)		\
> -	ib_wc_status(MW_BIND_ERR)		\
> -	ib_wc_status(BAD_RESP_ERR)		\
> -	ib_wc_status(LOC_ACCESS_ERR)		\
> -	ib_wc_status(REM_INV_REQ_ERR)		\
> -	ib_wc_status(REM_ACCESS_ERR)		\
> -	ib_wc_status(REM_OP_ERR)		\
> -	ib_wc_status(RETRY_EXC_ERR)		\
> -	ib_wc_status(RNR_RETRY_EXC_ERR)		\
> -	ib_wc_status(LOC_RDD_VIOL_ERR)		\
> -	ib_wc_status(REM_INV_RD_REQ_ERR)	\
> -	ib_wc_status(REM_ABORT_ERR)		\
> -	ib_wc_status(INV_EECN_ERR)		\
> -	ib_wc_status(INV_EEC_STATE_ERR)		\
> -	ib_wc_status(FATAL_ERR)			\
> -	ib_wc_status(RESP_TIMEOUT_ERR)		\
> -	ib_wc_status_end(GENERAL_ERR)
> -
> -#undef ib_wc_status
> -#undef ib_wc_status_end
> -
> -#define ib_wc_status(x)		TRACE_DEFINE_ENUM(IB_WC_##x);
> -#define ib_wc_status_end(x)	TRACE_DEFINE_ENUM(IB_WC_##x);
> -
> -IB_WC_STATUS_LIST
> -
> -#undef ib_wc_status
> -#undef ib_wc_status_end
> -
> -#define ib_wc_status(x)		{ IB_WC_##x, #x },
> -#define ib_wc_status_end(x)	{ IB_WC_##x, #x }
> -
> -#define rdma_show_wc_status(x) \
> -		__print_symbolic(x, IB_WC_STATUS_LIST)
> -
> -/*
> - * enum ib_cm_event_type, from include/rdma/ib_cm.h
> - */
> -#define IB_CM_EVENT_LIST			\
> -	ib_cm_event(REQ_ERROR)			\
> -	ib_cm_event(REQ_RECEIVED)		\
> -	ib_cm_event(REP_ERROR)			\
> -	ib_cm_event(REP_RECEIVED)		\
> -	ib_cm_event(RTU_RECEIVED)		\
> -	ib_cm_event(USER_ESTABLISHED)		\
> -	ib_cm_event(DREQ_ERROR)			\
> -	ib_cm_event(DREQ_RECEIVED)		\
> -	ib_cm_event(DREP_RECEIVED)		\
> -	ib_cm_event(TIMEWAIT_EXIT)		\
> -	ib_cm_event(MRA_RECEIVED)		\
> -	ib_cm_event(REJ_RECEIVED)		\
> -	ib_cm_event(LAP_ERROR)			\
> -	ib_cm_event(LAP_RECEIVED)		\
> -	ib_cm_event(APR_RECEIVED)		\
> -	ib_cm_event(SIDR_REQ_ERROR)		\
> -	ib_cm_event(SIDR_REQ_RECEIVED)		\
> -	ib_cm_event_end(SIDR_REP_RECEIVED)
> -
> -#undef ib_cm_event
> -#undef ib_cm_event_end
> -
> -#define ib_cm_event(x)		TRACE_DEFINE_ENUM(IB_CM_##x);
> -#define ib_cm_event_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
> -
> -IB_CM_EVENT_LIST
> -
> -#undef ib_cm_event
> -#undef ib_cm_event_end
> -
> -#define ib_cm_event(x)		{ IB_CM_##x, #x },
> -#define ib_cm_event_end(x)	{ IB_CM_##x, #x }
> -
> -#define rdma_show_ib_cm_event(x) \
> -		__print_symbolic(x, IB_CM_EVENT_LIST)
> -
> -/*
> - * enum rdma_cm_event_type, from include/rdma/rdma_cm.h
> - */
> -#define RDMA_CM_EVENT_LIST			\
> -	rdma_cm_event(ADDR_RESOLVED)		\
> -	rdma_cm_event(ADDR_ERROR)		\
> -	rdma_cm_event(ROUTE_RESOLVED)		\
> -	rdma_cm_event(ROUTE_ERROR)		\
> -	rdma_cm_event(CONNECT_REQUEST)		\
> -	rdma_cm_event(CONNECT_RESPONSE)		\
> -	rdma_cm_event(CONNECT_ERROR)		\
> -	rdma_cm_event(UNREACHABLE)		\
> -	rdma_cm_event(REJECTED)			\
> -	rdma_cm_event(ESTABLISHED)		\
> -	rdma_cm_event(DISCONNECTED)		\
> -	rdma_cm_event(DEVICE_REMOVAL)		\
> -	rdma_cm_event(MULTICAST_JOIN)		\
> -	rdma_cm_event(MULTICAST_ERROR)		\
> -	rdma_cm_event(ADDR_CHANGE)		\
> -	rdma_cm_event_end(TIMEWAIT_EXIT)
> -
> -#undef rdma_cm_event
> -#undef rdma_cm_event_end
> -
> -#define rdma_cm_event(x)	TRACE_DEFINE_ENUM(RDMA_CM_EVENT_##x);
> -#define rdma_cm_event_end(x)	TRACE_DEFINE_ENUM(RDMA_CM_EVENT_##x);
> -
> -RDMA_CM_EVENT_LIST
> -
> -#undef rdma_cm_event
> -#undef rdma_cm_event_end
> -
> -#define rdma_cm_event(x)	{ RDMA_CM_EVENT_##x, #x },
> -#define rdma_cm_event_end(x)	{ RDMA_CM_EVENT_##x, #x }
> -
> -#define rdma_show_cm_event(x) \
> -		__print_symbolic(x, RDMA_CM_EVENT_LIST)
> diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.=
h
> index c9048f3e471b..3f121eed369e 100644
> --- a/include/trace/events/rpcgss.h
> +++ b/include/trace/events/rpcgss.h
> @@ -13,7 +13,7 @@
>=20
> #include <linux/tracepoint.h>
>=20
> -#include <trace/events/sunrpc_base.h>
> +#include <trace/misc/sunrpc.h>
>=20
> /**
>  ** GSS-API related trace events
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdm=
a.h
> index fcd3b3f1020a..8f461e04e5f0 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -15,8 +15,8 @@
> #include <linux/tracepoint.h>
> #include <rdma/ib_cm.h>
>=20
> -#include <trace/events/rdma.h>
> -#include <trace/events/sunrpc_base.h>
> +#include <trace/misc/rdma.h>
> +#include <trace/misc/sunrpc.h>
>=20
> /**
>  ** Event classes
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.=
h
> index f48f2ab9d238..ffe2679a13ce 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -14,7 +14,7 @@
> #include <linux/net.h>
> #include <linux/tracepoint.h>
>=20
> -#include <trace/events/sunrpc_base.h>
> +#include <trace/misc/sunrpc.h>
>=20
> TRACE_DEFINE_ENUM(SOCK_STREAM);
> TRACE_DEFINE_ENUM(SOCK_DGRAM);
> diff --git a/include/trace/events/sunrpc_base.h b/include/trace/events/su=
nrpc_base.h
> deleted file mode 100644
> index 588557d07ea8..000000000000
> --- a/include/trace/events/sunrpc_base.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (c) 2021 Oracle and/or its affiliates.
> - *
> - * Common types and format specifiers for sunrpc.
> - */
> -
> -#if !defined(_TRACE_SUNRPC_BASE_H)
> -#define _TRACE_SUNRPC_BASE_H
> -
> -#include <linux/tracepoint.h>
> -
> -#define SUNRPC_TRACE_PID_SPECIFIER	"%08x"
> -#define SUNRPC_TRACE_CLID_SPECIFIER	"%08x"
> -#define SUNRPC_TRACE_TASK_SPECIFIER \
> -	"task:" SUNRPC_TRACE_PID_SPECIFIER "@" SUNRPC_TRACE_CLID_SPECIFIER
> -
> -#endif /* _TRACE_SUNRPC_BASE_H */
> diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
> new file mode 100644
> index 000000000000..738b97f22f36
> --- /dev/null
> +++ b/include/trace/misc/fs.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Display helpers for generic filesystem items
> + *
> + * Author: Chuck Lever <chuck.lever@oracle.com>
> + *
> + * Copyright (c) 2020, Oracle and/or its affiliates.
> + */
> +
> +#include <linux/fs.h>
> +
> +#define show_fs_dirent_type(x) \
> +	__print_symbolic(x, \
> +		{ DT_UNKNOWN,		"UNKNOWN" }, \
> +		{ DT_FIFO,		"FIFO" }, \
> +		{ DT_CHR,		"CHR" }, \
> +		{ DT_DIR,		"DIR" }, \
> +		{ DT_BLK,		"BLK" }, \
> +		{ DT_REG,		"REG" }, \
> +		{ DT_LNK,		"LNK" }, \
> +		{ DT_SOCK,		"SOCK" }, \
> +		{ DT_WHT,		"WHT" })
> +
> +#define show_fs_fcntl_open_flags(x) \
> +	__print_flags(x, "|", \
> +		{ O_WRONLY,		"O_WRONLY" }, \
> +		{ O_RDWR,		"O_RDWR" }, \
> +		{ O_CREAT,		"O_CREAT" }, \
> +		{ O_EXCL,		"O_EXCL" }, \
> +		{ O_NOCTTY,		"O_NOCTTY" }, \
> +		{ O_TRUNC,		"O_TRUNC" }, \
> +		{ O_APPEND,		"O_APPEND" }, \
> +		{ O_NONBLOCK,		"O_NONBLOCK" }, \
> +		{ O_DSYNC,		"O_DSYNC" }, \
> +		{ O_DIRECT,		"O_DIRECT" }, \
> +		{ O_LARGEFILE,		"O_LARGEFILE" }, \
> +		{ O_DIRECTORY,		"O_DIRECTORY" }, \
> +		{ O_NOFOLLOW,		"O_NOFOLLOW" }, \
> +		{ O_NOATIME,		"O_NOATIME" }, \
> +		{ O_CLOEXEC,		"O_CLOEXEC" })
> +
> +#define __fmode_flag(x)	{ (__force unsigned long)FMODE_##x, #x }
> +#define show_fs_fmode_flags(x) \
> +	__print_flags(x, "|", \
> +		__fmode_flag(READ), \
> +		__fmode_flag(WRITE), \
> +		__fmode_flag(EXEC))
> +
> +#ifdef CONFIG_64BIT
> +#define show_fs_fcntl_cmd(x) \
> +	__print_symbolic(x, \
> +		{ F_DUPFD,		"DUPFD" }, \
> +		{ F_GETFD,		"GETFD" }, \
> +		{ F_SETFD,		"SETFD" }, \
> +		{ F_GETFL,		"GETFL" }, \
> +		{ F_SETFL,		"SETFL" }, \
> +		{ F_GETLK,		"GETLK" }, \
> +		{ F_SETLK,		"SETLK" }, \
> +		{ F_SETLKW,		"SETLKW" }, \
> +		{ F_SETOWN,		"SETOWN" }, \
> +		{ F_GETOWN,		"GETOWN" }, \
> +		{ F_SETSIG,		"SETSIG" }, \
> +		{ F_GETSIG,		"GETSIG" }, \
> +		{ F_SETOWN_EX,		"SETOWN_EX" }, \
> +		{ F_GETOWN_EX,		"GETOWN_EX" }, \
> +		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
> +		{ F_OFD_GETLK,		"OFD_GETLK" }, \
> +		{ F_OFD_SETLK,		"OFD_SETLK" }, \
> +		{ F_OFD_SETLKW,		"OFD_SETLKW" })
> +#else /* CONFIG_64BIT */
> +#define show_fs_fcntl_cmd(x) \
> +	__print_symbolic(x, \
> +		{ F_DUPFD,		"DUPFD" }, \
> +		{ F_GETFD,		"GETFD" }, \
> +		{ F_SETFD,		"SETFD" }, \
> +		{ F_GETFL,		"GETFL" }, \
> +		{ F_SETFL,		"SETFL" }, \
> +		{ F_GETLK,		"GETLK" }, \
> +		{ F_SETLK,		"SETLK" }, \
> +		{ F_SETLKW,		"SETLKW" }, \
> +		{ F_SETOWN,		"SETOWN" }, \
> +		{ F_GETOWN,		"GETOWN" }, \
> +		{ F_SETSIG,		"SETSIG" }, \
> +		{ F_GETSIG,		"GETSIG" }, \
> +		{ F_GETLK64,		"GETLK64" }, \
> +		{ F_SETLK64,		"SETLK64" }, \
> +		{ F_SETLKW64,		"SETLKW64" }, \
> +		{ F_SETOWN_EX,		"SETOWN_EX" }, \
> +		{ F_GETOWN_EX,		"GETOWN_EX" }, \
> +		{ F_GETOWNER_UIDS,	"GETOWNER_UIDS" }, \
> +		{ F_OFD_GETLK,		"OFD_GETLK" }, \
> +		{ F_OFD_SETLK,		"OFD_SETLK" }, \
> +		{ F_OFD_SETLKW,		"OFD_SETLKW" })
> +#endif /* CONFIG_64BIT */
> +
> +#define show_fs_fcntl_lock_type(x) \
> +	__print_symbolic(x, \
> +		{ F_RDLCK,		"RDLCK" }, \
> +		{ F_WRLCK,		"WRLCK" }, \
> +		{ F_UNLCK,		"UNLCK" })
> +
> +#define show_fs_lookup_flags(flags) \
> +	__print_flags(flags, "|", \
> +		{ LOOKUP_FOLLOW,	"FOLLOW" }, \
> +		{ LOOKUP_DIRECTORY,	"DIRECTORY" }, \
> +		{ LOOKUP_AUTOMOUNT,	"AUTOMOUNT" }, \
> +		{ LOOKUP_EMPTY,		"EMPTY" }, \
> +		{ LOOKUP_DOWN,		"DOWN" }, \
> +		{ LOOKUP_MOUNTPOINT,	"MOUNTPOINT" }, \
> +		{ LOOKUP_REVAL,		"REVAL" }, \
> +		{ LOOKUP_RCU,		"RCU" }, \
> +		{ LOOKUP_OPEN,		"OPEN" }, \
> +		{ LOOKUP_CREATE,	"CREATE" }, \
> +		{ LOOKUP_EXCL,		"EXCL" }, \
> +		{ LOOKUP_RENAME_TARGET,	"RENAME_TARGET" }, \
> +		{ LOOKUP_PARENT,	"PARENT" }, \
> +		{ LOOKUP_NO_SYMLINKS,	"NO_SYMLINKS" }, \
> +		{ LOOKUP_NO_MAGICLINKS,	"NO_MAGICLINKS" }, \
> +		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
> +		{ LOOKUP_BENEATH,	"BENEATH" }, \
> +		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
> +		{ LOOKUP_CACHED,	"CACHED" })
> diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
> new file mode 100644
> index 000000000000..09ffdbb04134
> --- /dev/null
> +++ b/include/trace/misc/nfs.h
> @@ -0,0 +1,375 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Display helpers for NFS protocol elements
> + *
> + * Author: Chuck Lever <chuck.lever@oracle.com>
> + *
> + * Copyright (c) 2020, Oracle and/or its affiliates.
> + */
> +
> +#include <linux/nfs.h>
> +#include <linux/nfs4.h>
> +#include <uapi/linux/nfs.h>
> +
> +TRACE_DEFINE_ENUM(NFS_OK);
> +TRACE_DEFINE_ENUM(NFSERR_PERM);
> +TRACE_DEFINE_ENUM(NFSERR_NOENT);
> +TRACE_DEFINE_ENUM(NFSERR_IO);
> +TRACE_DEFINE_ENUM(NFSERR_NXIO);
> +TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
> +TRACE_DEFINE_ENUM(NFSERR_ACCES);
> +TRACE_DEFINE_ENUM(NFSERR_EXIST);
> +TRACE_DEFINE_ENUM(NFSERR_XDEV);
> +TRACE_DEFINE_ENUM(NFSERR_NODEV);
> +TRACE_DEFINE_ENUM(NFSERR_NOTDIR);
> +TRACE_DEFINE_ENUM(NFSERR_ISDIR);
> +TRACE_DEFINE_ENUM(NFSERR_INVAL);
> +TRACE_DEFINE_ENUM(NFSERR_FBIG);
> +TRACE_DEFINE_ENUM(NFSERR_NOSPC);
> +TRACE_DEFINE_ENUM(NFSERR_ROFS);
> +TRACE_DEFINE_ENUM(NFSERR_MLINK);
> +TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
> +TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
> +TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
> +TRACE_DEFINE_ENUM(NFSERR_DQUOT);
> +TRACE_DEFINE_ENUM(NFSERR_STALE);
> +TRACE_DEFINE_ENUM(NFSERR_REMOTE);
> +TRACE_DEFINE_ENUM(NFSERR_WFLUSH);
> +TRACE_DEFINE_ENUM(NFSERR_BADHANDLE);
> +TRACE_DEFINE_ENUM(NFSERR_NOT_SYNC);
> +TRACE_DEFINE_ENUM(NFSERR_BAD_COOKIE);
> +TRACE_DEFINE_ENUM(NFSERR_NOTSUPP);
> +TRACE_DEFINE_ENUM(NFSERR_TOOSMALL);
> +TRACE_DEFINE_ENUM(NFSERR_SERVERFAULT);
> +TRACE_DEFINE_ENUM(NFSERR_BADTYPE);
> +TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
> +
> +#define show_nfs_status(x) \
> +	__print_symbolic(x, \
> +		{ NFS_OK,			"OK" }, \
> +		{ NFSERR_PERM,			"PERM" }, \
> +		{ NFSERR_NOENT,			"NOENT" }, \
> +		{ NFSERR_IO,			"IO" }, \
> +		{ NFSERR_NXIO,			"NXIO" }, \
> +		{ ECHILD,			"CHILD" }, \
> +		{ NFSERR_EAGAIN,		"AGAIN" }, \
> +		{ NFSERR_ACCES,			"ACCES" }, \
> +		{ NFSERR_EXIST,			"EXIST" }, \
> +		{ NFSERR_XDEV,			"XDEV" }, \
> +		{ NFSERR_NODEV,			"NODEV" }, \
> +		{ NFSERR_NOTDIR,		"NOTDIR" }, \
> +		{ NFSERR_ISDIR,			"ISDIR" }, \
> +		{ NFSERR_INVAL,			"INVAL" }, \
> +		{ NFSERR_FBIG,			"FBIG" }, \
> +		{ NFSERR_NOSPC,			"NOSPC" }, \
> +		{ NFSERR_ROFS,			"ROFS" }, \
> +		{ NFSERR_MLINK,			"MLINK" }, \
> +		{ NFSERR_OPNOTSUPP,		"OPNOTSUPP" }, \
> +		{ NFSERR_NAMETOOLONG,		"NAMETOOLONG" }, \
> +		{ NFSERR_NOTEMPTY,		"NOTEMPTY" }, \
> +		{ NFSERR_DQUOT,			"DQUOT" }, \
> +		{ NFSERR_STALE,			"STALE" }, \
> +		{ NFSERR_REMOTE,		"REMOTE" }, \
> +		{ NFSERR_WFLUSH,		"WFLUSH" }, \
> +		{ NFSERR_BADHANDLE,		"BADHANDLE" }, \
> +		{ NFSERR_NOT_SYNC,		"NOTSYNC" }, \
> +		{ NFSERR_BAD_COOKIE,		"BADCOOKIE" }, \
> +		{ NFSERR_NOTSUPP,		"NOTSUPP" }, \
> +		{ NFSERR_TOOSMALL,		"TOOSMALL" }, \
> +		{ NFSERR_SERVERFAULT,		"REMOTEIO" }, \
> +		{ NFSERR_BADTYPE,		"BADTYPE" }, \
> +		{ NFSERR_JUKEBOX,		"JUKEBOX" })
> +
> +TRACE_DEFINE_ENUM(NFS_UNSTABLE);
> +TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
> +TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
> +
> +#define show_nfs_stable_how(x) \
> +	__print_symbolic(x, \
> +		{ NFS_UNSTABLE,			"UNSTABLE" }, \
> +		{ NFS_DATA_SYNC,		"DATA_SYNC" }, \
> +		{ NFS_FILE_SYNC,		"FILE_SYNC" })
> +
> +TRACE_DEFINE_ENUM(NFS4_OK);
> +TRACE_DEFINE_ENUM(NFS4ERR_ACCESS);
> +TRACE_DEFINE_ENUM(NFS4ERR_ATTRNOTSUPP);
> +TRACE_DEFINE_ENUM(NFS4ERR_ADMIN_REVOKED);
> +TRACE_DEFINE_ENUM(NFS4ERR_BACK_CHAN_BUSY);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADCHAR);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADHANDLE);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADIOMODE);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADLAYOUT);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADLABEL);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADNAME);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADOWNER);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADSESSION);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADSLOT);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADTYPE);
> +TRACE_DEFINE_ENUM(NFS4ERR_BADXDR);
> +TRACE_DEFINE_ENUM(NFS4ERR_BAD_COOKIE);
> +TRACE_DEFINE_ENUM(NFS4ERR_BAD_HIGH_SLOT);
> +TRACE_DEFINE_ENUM(NFS4ERR_BAD_RANGE);
> +TRACE_DEFINE_ENUM(NFS4ERR_BAD_SEQID);
> +TRACE_DEFINE_ENUM(NFS4ERR_BAD_SESSION_DIGEST);
> +TRACE_DEFINE_ENUM(NFS4ERR_BAD_STATEID);
> +TRACE_DEFINE_ENUM(NFS4ERR_CB_PATH_DOWN);
> +TRACE_DEFINE_ENUM(NFS4ERR_CLID_INUSE);
> +TRACE_DEFINE_ENUM(NFS4ERR_CLIENTID_BUSY);
> +TRACE_DEFINE_ENUM(NFS4ERR_COMPLETE_ALREADY);
> +TRACE_DEFINE_ENUM(NFS4ERR_CONN_NOT_BOUND_TO_SESSION);
> +TRACE_DEFINE_ENUM(NFS4ERR_DEADLOCK);
> +TRACE_DEFINE_ENUM(NFS4ERR_DEADSESSION);
> +TRACE_DEFINE_ENUM(NFS4ERR_DELAY);
> +TRACE_DEFINE_ENUM(NFS4ERR_DELEG_ALREADY_WANTED);
> +TRACE_DEFINE_ENUM(NFS4ERR_DELEG_REVOKED);
> +TRACE_DEFINE_ENUM(NFS4ERR_DENIED);
> +TRACE_DEFINE_ENUM(NFS4ERR_DIRDELEG_UNAVAIL);
> +TRACE_DEFINE_ENUM(NFS4ERR_DQUOT);
> +TRACE_DEFINE_ENUM(NFS4ERR_ENCR_ALG_UNSUPP);
> +TRACE_DEFINE_ENUM(NFS4ERR_EXIST);
> +TRACE_DEFINE_ENUM(NFS4ERR_EXPIRED);
> +TRACE_DEFINE_ENUM(NFS4ERR_FBIG);
> +TRACE_DEFINE_ENUM(NFS4ERR_FHEXPIRED);
> +TRACE_DEFINE_ENUM(NFS4ERR_FILE_OPEN);
> +TRACE_DEFINE_ENUM(NFS4ERR_GRACE);
> +TRACE_DEFINE_ENUM(NFS4ERR_HASH_ALG_UNSUPP);
> +TRACE_DEFINE_ENUM(NFS4ERR_INVAL);
> +TRACE_DEFINE_ENUM(NFS4ERR_IO);
> +TRACE_DEFINE_ENUM(NFS4ERR_ISDIR);
> +TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTTRYLATER);
> +TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTUNAVAILABLE);
> +TRACE_DEFINE_ENUM(NFS4ERR_LEASE_MOVED);
> +TRACE_DEFINE_ENUM(NFS4ERR_LOCKED);
> +TRACE_DEFINE_ENUM(NFS4ERR_LOCKS_HELD);
> +TRACE_DEFINE_ENUM(NFS4ERR_LOCK_RANGE);
> +TRACE_DEFINE_ENUM(NFS4ERR_MINOR_VERS_MISMATCH);
> +TRACE_DEFINE_ENUM(NFS4ERR_MLINK);
> +TRACE_DEFINE_ENUM(NFS4ERR_MOVED);
> +TRACE_DEFINE_ENUM(NFS4ERR_NAMETOOLONG);
> +TRACE_DEFINE_ENUM(NFS4ERR_NOENT);
> +TRACE_DEFINE_ENUM(NFS4ERR_NOFILEHANDLE);
> +TRACE_DEFINE_ENUM(NFS4ERR_NOMATCHING_LAYOUT);
> +TRACE_DEFINE_ENUM(NFS4ERR_NOSPC);
> +TRACE_DEFINE_ENUM(NFS4ERR_NOTDIR);
> +TRACE_DEFINE_ENUM(NFS4ERR_NOTEMPTY);
> +TRACE_DEFINE_ENUM(NFS4ERR_NOTSUPP);
> +TRACE_DEFINE_ENUM(NFS4ERR_NOT_ONLY_OP);
> +TRACE_DEFINE_ENUM(NFS4ERR_NOT_SAME);
> +TRACE_DEFINE_ENUM(NFS4ERR_NO_GRACE);
> +TRACE_DEFINE_ENUM(NFS4ERR_NXIO);
> +TRACE_DEFINE_ENUM(NFS4ERR_OLD_STATEID);
> +TRACE_DEFINE_ENUM(NFS4ERR_OPENMODE);
> +TRACE_DEFINE_ENUM(NFS4ERR_OP_ILLEGAL);
> +TRACE_DEFINE_ENUM(NFS4ERR_OP_NOT_IN_SESSION);
> +TRACE_DEFINE_ENUM(NFS4ERR_PERM);
> +TRACE_DEFINE_ENUM(NFS4ERR_PNFS_IO_HOLE);
> +TRACE_DEFINE_ENUM(NFS4ERR_PNFS_NO_LAYOUT);
> +TRACE_DEFINE_ENUM(NFS4ERR_RECALLCONFLICT);
> +TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_BAD);
> +TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_CONFLICT);
> +TRACE_DEFINE_ENUM(NFS4ERR_REJECT_DELEG);
> +TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG);
> +TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG_TO_CACHE);
> +TRACE_DEFINE_ENUM(NFS4ERR_REQ_TOO_BIG);
> +TRACE_DEFINE_ENUM(NFS4ERR_RESOURCE);
> +TRACE_DEFINE_ENUM(NFS4ERR_RESTOREFH);
> +TRACE_DEFINE_ENUM(NFS4ERR_RETRY_UNCACHED_REP);
> +TRACE_DEFINE_ENUM(NFS4ERR_RETURNCONFLICT);
> +TRACE_DEFINE_ENUM(NFS4ERR_ROFS);
> +TRACE_DEFINE_ENUM(NFS4ERR_SAME);
> +TRACE_DEFINE_ENUM(NFS4ERR_SHARE_DENIED);
> +TRACE_DEFINE_ENUM(NFS4ERR_SEQUENCE_POS);
> +TRACE_DEFINE_ENUM(NFS4ERR_SEQ_FALSE_RETRY);
> +TRACE_DEFINE_ENUM(NFS4ERR_SEQ_MISORDERED);
> +TRACE_DEFINE_ENUM(NFS4ERR_SERVERFAULT);
> +TRACE_DEFINE_ENUM(NFS4ERR_STALE);
> +TRACE_DEFINE_ENUM(NFS4ERR_STALE_CLIENTID);
> +TRACE_DEFINE_ENUM(NFS4ERR_STALE_STATEID);
> +TRACE_DEFINE_ENUM(NFS4ERR_SYMLINK);
> +TRACE_DEFINE_ENUM(NFS4ERR_TOOSMALL);
> +TRACE_DEFINE_ENUM(NFS4ERR_TOO_MANY_OPS);
> +TRACE_DEFINE_ENUM(NFS4ERR_UNKNOWN_LAYOUTTYPE);
> +TRACE_DEFINE_ENUM(NFS4ERR_UNSAFE_COMPOUND);
> +TRACE_DEFINE_ENUM(NFS4ERR_WRONGSEC);
> +TRACE_DEFINE_ENUM(NFS4ERR_WRONG_CRED);
> +TRACE_DEFINE_ENUM(NFS4ERR_WRONG_TYPE);
> +TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
> +
> +TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_MDS);
> +TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
> +
> +#define show_nfs4_status(x) \
> +	__print_symbolic(x, \
> +		{ NFS4_OK,			"OK" }, \
> +		{ EPERM,			"EPERM" }, \
> +		{ ENOENT,			"ENOENT" }, \
> +		{ EIO,				"EIO" }, \
> +		{ ENXIO,			"ENXIO" }, \
> +		{ EACCES,			"EACCES" }, \
> +		{ EEXIST,			"EEXIST" }, \
> +		{ EXDEV,			"EXDEV" }, \
> +		{ ENOTDIR,			"ENOTDIR" }, \
> +		{ EISDIR,			"EISDIR" }, \
> +		{ EFBIG,			"EFBIG" }, \
> +		{ ENOSPC,			"ENOSPC" }, \
> +		{ EROFS,			"EROFS" }, \
> +		{ EMLINK,			"EMLINK" }, \
> +		{ ENAMETOOLONG,			"ENAMETOOLONG" }, \
> +		{ ENOTEMPTY,			"ENOTEMPTY" }, \
> +		{ EDQUOT,			"EDQUOT" }, \
> +		{ ESTALE,			"ESTALE" }, \
> +		{ EBADHANDLE,			"EBADHANDLE" }, \
> +		{ EBADCOOKIE,			"EBADCOOKIE" }, \
> +		{ ENOTSUPP,			"ENOTSUPP" }, \
> +		{ ETOOSMALL,			"ETOOSMALL" }, \
> +		{ EREMOTEIO,			"EREMOTEIO" }, \
> +		{ EBADTYPE,			"EBADTYPE" }, \
> +		{ EAGAIN,			"EAGAIN" }, \
> +		{ ELOOP,			"ELOOP" }, \
> +		{ EOPNOTSUPP,			"EOPNOTSUPP" }, \
> +		{ EDEADLK,			"EDEADLK" }, \
> +		{ ENOMEM,			"ENOMEM" }, \
> +		{ EKEYEXPIRED,			"EKEYEXPIRED" }, \
> +		{ ETIMEDOUT,			"ETIMEDOUT" }, \
> +		{ ERESTARTSYS,			"ERESTARTSYS" }, \
> +		{ ECONNREFUSED,			"ECONNREFUSED" }, \
> +		{ ECONNRESET,			"ECONNRESET" }, \
> +		{ ENETUNREACH,			"ENETUNREACH" }, \
> +		{ EHOSTUNREACH,			"EHOSTUNREACH" }, \
> +		{ EHOSTDOWN,			"EHOSTDOWN" }, \
> +		{ EPIPE,			"EPIPE" }, \
> +		{ EPFNOSUPPORT,			"EPFNOSUPPORT" }, \
> +		{ EPROTONOSUPPORT,		"EPROTONOSUPPORT" }, \
> +		{ NFS4ERR_ACCESS,		"ACCESS" }, \
> +		{ NFS4ERR_ATTRNOTSUPP,		"ATTRNOTSUPP" }, \
> +		{ NFS4ERR_ADMIN_REVOKED,	"ADMIN_REVOKED" }, \
> +		{ NFS4ERR_BACK_CHAN_BUSY,	"BACK_CHAN_BUSY" }, \
> +		{ NFS4ERR_BADCHAR,		"BADCHAR" }, \
> +		{ NFS4ERR_BADHANDLE,		"BADHANDLE" }, \
> +		{ NFS4ERR_BADIOMODE,		"BADIOMODE" }, \
> +		{ NFS4ERR_BADLAYOUT,		"BADLAYOUT" }, \
> +		{ NFS4ERR_BADLABEL,		"BADLABEL" }, \
> +		{ NFS4ERR_BADNAME,		"BADNAME" }, \
> +		{ NFS4ERR_BADOWNER,		"BADOWNER" }, \
> +		{ NFS4ERR_BADSESSION,		"BADSESSION" }, \
> +		{ NFS4ERR_BADSLOT,		"BADSLOT" }, \
> +		{ NFS4ERR_BADTYPE,		"BADTYPE" }, \
> +		{ NFS4ERR_BADXDR,		"BADXDR" }, \
> +		{ NFS4ERR_BAD_COOKIE,		"BAD_COOKIE" }, \
> +		{ NFS4ERR_BAD_HIGH_SLOT,	"BAD_HIGH_SLOT" }, \
> +		{ NFS4ERR_BAD_RANGE,		"BAD_RANGE" }, \
> +		{ NFS4ERR_BAD_SEQID,		"BAD_SEQID" }, \
> +		{ NFS4ERR_BAD_SESSION_DIGEST,	"BAD_SESSION_DIGEST" }, \
> +		{ NFS4ERR_BAD_STATEID,		"BAD_STATEID" }, \
> +		{ NFS4ERR_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
> +		{ NFS4ERR_CLID_INUSE,		"CLID_INUSE" }, \
> +		{ NFS4ERR_CLIENTID_BUSY,	"CLIENTID_BUSY" }, \
> +		{ NFS4ERR_COMPLETE_ALREADY,	"COMPLETE_ALREADY" }, \
> +		{ NFS4ERR_CONN_NOT_BOUND_TO_SESSION, "CONN_NOT_BOUND_TO_SESSION" }, \
> +		{ NFS4ERR_DEADLOCK,		"DEADLOCK" }, \
> +		{ NFS4ERR_DEADSESSION,		"DEAD_SESSION" }, \
> +		{ NFS4ERR_DELAY,		"DELAY" }, \
> +		{ NFS4ERR_DELEG_ALREADY_WANTED,	"DELEG_ALREADY_WANTED" }, \
> +		{ NFS4ERR_DELEG_REVOKED,	"DELEG_REVOKED" }, \
> +		{ NFS4ERR_DENIED,		"DENIED" }, \
> +		{ NFS4ERR_DIRDELEG_UNAVAIL,	"DIRDELEG_UNAVAIL" }, \
> +		{ NFS4ERR_DQUOT,		"DQUOT" }, \
> +		{ NFS4ERR_ENCR_ALG_UNSUPP,	"ENCR_ALG_UNSUPP" }, \
> +		{ NFS4ERR_EXIST,		"EXIST" }, \
> +		{ NFS4ERR_EXPIRED,		"EXPIRED" }, \
> +		{ NFS4ERR_FBIG,			"FBIG" }, \
> +		{ NFS4ERR_FHEXPIRED,		"FHEXPIRED" }, \
> +		{ NFS4ERR_FILE_OPEN,		"FILE_OPEN" }, \
> +		{ NFS4ERR_GRACE,		"GRACE" }, \
> +		{ NFS4ERR_HASH_ALG_UNSUPP,	"HASH_ALG_UNSUPP" }, \
> +		{ NFS4ERR_INVAL,		"INVAL" }, \
> +		{ NFS4ERR_IO,			"IO" }, \
> +		{ NFS4ERR_ISDIR,		"ISDIR" }, \
> +		{ NFS4ERR_LAYOUTTRYLATER,	"LAYOUTTRYLATER" }, \
> +		{ NFS4ERR_LAYOUTUNAVAILABLE,	"LAYOUTUNAVAILABLE" }, \
> +		{ NFS4ERR_LEASE_MOVED,		"LEASE_MOVED" }, \
> +		{ NFS4ERR_LOCKED,		"LOCKED" }, \
> +		{ NFS4ERR_LOCKS_HELD,		"LOCKS_HELD" }, \
> +		{ NFS4ERR_LOCK_RANGE,		"LOCK_RANGE" }, \
> +		{ NFS4ERR_MINOR_VERS_MISMATCH,	"MINOR_VERS_MISMATCH" }, \
> +		{ NFS4ERR_MLINK,		"MLINK" }, \
> +		{ NFS4ERR_MOVED,		"MOVED" }, \
> +		{ NFS4ERR_NAMETOOLONG,		"NAMETOOLONG" }, \
> +		{ NFS4ERR_NOENT,		"NOENT" }, \
> +		{ NFS4ERR_NOFILEHANDLE,		"NOFILEHANDLE" }, \
> +		{ NFS4ERR_NOMATCHING_LAYOUT,	"NOMATCHING_LAYOUT" }, \
> +		{ NFS4ERR_NOSPC,		"NOSPC" }, \
> +		{ NFS4ERR_NOTDIR,		"NOTDIR" }, \
> +		{ NFS4ERR_NOTEMPTY,		"NOTEMPTY" }, \
> +		{ NFS4ERR_NOTSUPP,		"NOTSUPP" }, \
> +		{ NFS4ERR_NOT_ONLY_OP,		"NOT_ONLY_OP" }, \
> +		{ NFS4ERR_NOT_SAME,		"NOT_SAME" }, \
> +		{ NFS4ERR_NO_GRACE,		"NO_GRACE" }, \
> +		{ NFS4ERR_NXIO,			"NXIO" }, \
> +		{ NFS4ERR_OLD_STATEID,		"OLD_STATEID" }, \
> +		{ NFS4ERR_OPENMODE,		"OPENMODE" }, \
> +		{ NFS4ERR_OP_ILLEGAL,		"OP_ILLEGAL" }, \
> +		{ NFS4ERR_OP_NOT_IN_SESSION,	"OP_NOT_IN_SESSION" }, \
> +		{ NFS4ERR_PERM,			"PERM" }, \
> +		{ NFS4ERR_PNFS_IO_HOLE,		"PNFS_IO_HOLE" }, \
> +		{ NFS4ERR_PNFS_NO_LAYOUT,	"PNFS_NO_LAYOUT" }, \
> +		{ NFS4ERR_RECALLCONFLICT,	"RECALLCONFLICT" }, \
> +		{ NFS4ERR_RECLAIM_BAD,		"RECLAIM_BAD" }, \
> +		{ NFS4ERR_RECLAIM_CONFLICT,	"RECLAIM_CONFLICT" }, \
> +		{ NFS4ERR_REJECT_DELEG,		"REJECT_DELEG" }, \
> +		{ NFS4ERR_REP_TOO_BIG,		"REP_TOO_BIG" }, \
> +		{ NFS4ERR_REP_TOO_BIG_TO_CACHE,	"REP_TOO_BIG_TO_CACHE" }, \
> +		{ NFS4ERR_REQ_TOO_BIG,		"REQ_TOO_BIG" }, \
> +		{ NFS4ERR_RESOURCE,		"RESOURCE" }, \
> +		{ NFS4ERR_RESTOREFH,		"RESTOREFH" }, \
> +		{ NFS4ERR_RETRY_UNCACHED_REP,	"RETRY_UNCACHED_REP" }, \
> +		{ NFS4ERR_RETURNCONFLICT,	"RETURNCONFLICT" }, \
> +		{ NFS4ERR_ROFS,			"ROFS" }, \
> +		{ NFS4ERR_SAME,			"SAME" }, \
> +		{ NFS4ERR_SHARE_DENIED,		"SHARE_DENIED" }, \
> +		{ NFS4ERR_SEQUENCE_POS,		"SEQUENCE_POS" }, \
> +		{ NFS4ERR_SEQ_FALSE_RETRY,	"SEQ_FALSE_RETRY" }, \
> +		{ NFS4ERR_SEQ_MISORDERED,	"SEQ_MISORDERED" }, \
> +		{ NFS4ERR_SERVERFAULT,		"SERVERFAULT" }, \
> +		{ NFS4ERR_STALE,		"STALE" }, \
> +		{ NFS4ERR_STALE_CLIENTID,	"STALE_CLIENTID" }, \
> +		{ NFS4ERR_STALE_STATEID,	"STALE_STATEID" }, \
> +		{ NFS4ERR_SYMLINK,		"SYMLINK" }, \
> +		{ NFS4ERR_TOOSMALL,		"TOOSMALL" }, \
> +		{ NFS4ERR_TOO_MANY_OPS,		"TOO_MANY_OPS" }, \
> +		{ NFS4ERR_UNKNOWN_LAYOUTTYPE,	"UNKNOWN_LAYOUTTYPE" }, \
> +		{ NFS4ERR_UNSAFE_COMPOUND,	"UNSAFE_COMPOUND" }, \
> +		{ NFS4ERR_WRONGSEC,		"WRONGSEC" }, \
> +		{ NFS4ERR_WRONG_CRED,		"WRONG_CRED" }, \
> +		{ NFS4ERR_WRONG_TYPE,		"WRONG_TYPE" }, \
> +		{ NFS4ERR_XDEV,			"XDEV" }, \
> +		/* ***** Internal to Linux NFS client ***** */ \
> +		{ NFS4ERR_RESET_TO_MDS,		"RESET_TO_MDS" }, \
> +		{ NFS4ERR_RESET_TO_PNFS,	"RESET_TO_PNFS" })
> +
> +#define show_nfs4_verifier(x) \
> +	__print_hex_str(x, NFS4_VERIFIER_SIZE)
> +
> +TRACE_DEFINE_ENUM(IOMODE_READ);
> +TRACE_DEFINE_ENUM(IOMODE_RW);
> +TRACE_DEFINE_ENUM(IOMODE_ANY);
> +
> +#define show_pnfs_layout_iomode(x) \
> +	__print_symbolic(x, \
> +		{ IOMODE_READ,			"READ" }, \
> +		{ IOMODE_RW,			"RW" }, \
> +		{ IOMODE_ANY,			"ANY" })
> +
> +#define show_nfs4_seq4_status(x) \
> +	__print_flags(x, "|", \
> +		{ SEQ4_STATUS_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
> +		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING,	"CB_GSS_CONTEXTS_EXPIRING" }, =
\
> +		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED,	"CB_GSS_CONTEXTS_EXPIRED" }, \
> +		{ SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED, "EXPIRED_ALL_STATE_REVOKED" }=
, \
> +		{ SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED, "EXPIRED_SOME_STATE_REVOKED"=
 }, \
> +		{ SEQ4_STATUS_ADMIN_STATE_REVOKED,	"ADMIN_STATE_REVOKED" }, \
> +		{ SEQ4_STATUS_RECALLABLE_STATE_REVOKED,	"RECALLABLE_STATE_REVOKED" }, =
\
> +		{ SEQ4_STATUS_LEASE_MOVED,		"LEASE_MOVED" }, \
> +		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED,	"RESTART_RECLAIM_NEEDED" }, \
> +		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION,	"CB_PATH_DOWN_SESSION" }, \
> +		{ SEQ4_STATUS_BACKCHANNEL_FAULT,	"BACKCHANNEL_FAULT" })
> diff --git a/include/trace/misc/rdma.h b/include/trace/misc/rdma.h
> new file mode 100644
> index 000000000000..81bb454fc288
> --- /dev/null
> +++ b/include/trace/misc/rdma.h
> @@ -0,0 +1,168 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2017 Oracle.  All rights reserved.
> + */
> +
> +/*
> + * enum ib_event_type, from include/rdma/ib_verbs.h
> + */
> +#define IB_EVENT_LIST				\
> +	ib_event(CQ_ERR)			\
> +	ib_event(QP_FATAL)			\
> +	ib_event(QP_REQ_ERR)			\
> +	ib_event(QP_ACCESS_ERR)			\
> +	ib_event(COMM_EST)			\
> +	ib_event(SQ_DRAINED)			\
> +	ib_event(PATH_MIG)			\
> +	ib_event(PATH_MIG_ERR)			\
> +	ib_event(DEVICE_FATAL)			\
> +	ib_event(PORT_ACTIVE)			\
> +	ib_event(PORT_ERR)			\
> +	ib_event(LID_CHANGE)			\
> +	ib_event(PKEY_CHANGE)			\
> +	ib_event(SM_CHANGE)			\
> +	ib_event(SRQ_ERR)			\
> +	ib_event(SRQ_LIMIT_REACHED)		\
> +	ib_event(QP_LAST_WQE_REACHED)		\
> +	ib_event(CLIENT_REREGISTER)		\
> +	ib_event(GID_CHANGE)			\
> +	ib_event_end(WQ_FATAL)
> +
> +#undef ib_event
> +#undef ib_event_end
> +
> +#define ib_event(x)		TRACE_DEFINE_ENUM(IB_EVENT_##x);
> +#define ib_event_end(x)		TRACE_DEFINE_ENUM(IB_EVENT_##x);
> +
> +IB_EVENT_LIST
> +
> +#undef ib_event
> +#undef ib_event_end
> +
> +#define ib_event(x)		{ IB_EVENT_##x, #x },
> +#define ib_event_end(x)		{ IB_EVENT_##x, #x }
> +
> +#define rdma_show_ib_event(x) \
> +		__print_symbolic(x, IB_EVENT_LIST)
> +
> +/*
> + * enum ib_wc_status type, from include/rdma/ib_verbs.h
> + */
> +#define IB_WC_STATUS_LIST			\
> +	ib_wc_status(SUCCESS)			\
> +	ib_wc_status(LOC_LEN_ERR)		\
> +	ib_wc_status(LOC_QP_OP_ERR)		\
> +	ib_wc_status(LOC_EEC_OP_ERR)		\
> +	ib_wc_status(LOC_PROT_ERR)		\
> +	ib_wc_status(WR_FLUSH_ERR)		\
> +	ib_wc_status(MW_BIND_ERR)		\
> +	ib_wc_status(BAD_RESP_ERR)		\
> +	ib_wc_status(LOC_ACCESS_ERR)		\
> +	ib_wc_status(REM_INV_REQ_ERR)		\
> +	ib_wc_status(REM_ACCESS_ERR)		\
> +	ib_wc_status(REM_OP_ERR)		\
> +	ib_wc_status(RETRY_EXC_ERR)		\
> +	ib_wc_status(RNR_RETRY_EXC_ERR)		\
> +	ib_wc_status(LOC_RDD_VIOL_ERR)		\
> +	ib_wc_status(REM_INV_RD_REQ_ERR)	\
> +	ib_wc_status(REM_ABORT_ERR)		\
> +	ib_wc_status(INV_EECN_ERR)		\
> +	ib_wc_status(INV_EEC_STATE_ERR)		\
> +	ib_wc_status(FATAL_ERR)			\
> +	ib_wc_status(RESP_TIMEOUT_ERR)		\
> +	ib_wc_status_end(GENERAL_ERR)
> +
> +#undef ib_wc_status
> +#undef ib_wc_status_end
> +
> +#define ib_wc_status(x)		TRACE_DEFINE_ENUM(IB_WC_##x);
> +#define ib_wc_status_end(x)	TRACE_DEFINE_ENUM(IB_WC_##x);
> +
> +IB_WC_STATUS_LIST
> +
> +#undef ib_wc_status
> +#undef ib_wc_status_end
> +
> +#define ib_wc_status(x)		{ IB_WC_##x, #x },
> +#define ib_wc_status_end(x)	{ IB_WC_##x, #x }
> +
> +#define rdma_show_wc_status(x) \
> +		__print_symbolic(x, IB_WC_STATUS_LIST)
> +
> +/*
> + * enum ib_cm_event_type, from include/rdma/ib_cm.h
> + */
> +#define IB_CM_EVENT_LIST			\
> +	ib_cm_event(REQ_ERROR)			\
> +	ib_cm_event(REQ_RECEIVED)		\
> +	ib_cm_event(REP_ERROR)			\
> +	ib_cm_event(REP_RECEIVED)		\
> +	ib_cm_event(RTU_RECEIVED)		\
> +	ib_cm_event(USER_ESTABLISHED)		\
> +	ib_cm_event(DREQ_ERROR)			\
> +	ib_cm_event(DREQ_RECEIVED)		\
> +	ib_cm_event(DREP_RECEIVED)		\
> +	ib_cm_event(TIMEWAIT_EXIT)		\
> +	ib_cm_event(MRA_RECEIVED)		\
> +	ib_cm_event(REJ_RECEIVED)		\
> +	ib_cm_event(LAP_ERROR)			\
> +	ib_cm_event(LAP_RECEIVED)		\
> +	ib_cm_event(APR_RECEIVED)		\
> +	ib_cm_event(SIDR_REQ_ERROR)		\
> +	ib_cm_event(SIDR_REQ_RECEIVED)		\
> +	ib_cm_event_end(SIDR_REP_RECEIVED)
> +
> +#undef ib_cm_event
> +#undef ib_cm_event_end
> +
> +#define ib_cm_event(x)		TRACE_DEFINE_ENUM(IB_CM_##x);
> +#define ib_cm_event_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
> +
> +IB_CM_EVENT_LIST
> +
> +#undef ib_cm_event
> +#undef ib_cm_event_end
> +
> +#define ib_cm_event(x)		{ IB_CM_##x, #x },
> +#define ib_cm_event_end(x)	{ IB_CM_##x, #x }
> +
> +#define rdma_show_ib_cm_event(x) \
> +		__print_symbolic(x, IB_CM_EVENT_LIST)
> +
> +/*
> + * enum rdma_cm_event_type, from include/rdma/rdma_cm.h
> + */
> +#define RDMA_CM_EVENT_LIST			\
> +	rdma_cm_event(ADDR_RESOLVED)		\
> +	rdma_cm_event(ADDR_ERROR)		\
> +	rdma_cm_event(ROUTE_RESOLVED)		\
> +	rdma_cm_event(ROUTE_ERROR)		\
> +	rdma_cm_event(CONNECT_REQUEST)		\
> +	rdma_cm_event(CONNECT_RESPONSE)		\
> +	rdma_cm_event(CONNECT_ERROR)		\
> +	rdma_cm_event(UNREACHABLE)		\
> +	rdma_cm_event(REJECTED)			\
> +	rdma_cm_event(ESTABLISHED)		\
> +	rdma_cm_event(DISCONNECTED)		\
> +	rdma_cm_event(DEVICE_REMOVAL)		\
> +	rdma_cm_event(MULTICAST_JOIN)		\
> +	rdma_cm_event(MULTICAST_ERROR)		\
> +	rdma_cm_event(ADDR_CHANGE)		\
> +	rdma_cm_event_end(TIMEWAIT_EXIT)
> +
> +#undef rdma_cm_event
> +#undef rdma_cm_event_end
> +
> +#define rdma_cm_event(x)	TRACE_DEFINE_ENUM(RDMA_CM_EVENT_##x);
> +#define rdma_cm_event_end(x)	TRACE_DEFINE_ENUM(RDMA_CM_EVENT_##x);
> +
> +RDMA_CM_EVENT_LIST
> +
> +#undef rdma_cm_event
> +#undef rdma_cm_event_end
> +
> +#define rdma_cm_event(x)	{ RDMA_CM_EVENT_##x, #x },
> +#define rdma_cm_event_end(x)	{ RDMA_CM_EVENT_##x, #x }
> +
> +#define rdma_show_cm_event(x) \
> +		__print_symbolic(x, RDMA_CM_EVENT_LIST)
> diff --git a/include/trace/misc/sunrpc.h b/include/trace/misc/sunrpc.h
> new file mode 100644
> index 000000000000..588557d07ea8
> --- /dev/null
> +++ b/include/trace/misc/sunrpc.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 Oracle and/or its affiliates.
> + *
> + * Common types and format specifiers for sunrpc.
> + */
> +
> +#if !defined(_TRACE_SUNRPC_BASE_H)
> +#define _TRACE_SUNRPC_BASE_H
> +
> +#include <linux/tracepoint.h>
> +
> +#define SUNRPC_TRACE_PID_SPECIFIER	"%08x"
> +#define SUNRPC_TRACE_CLID_SPECIFIER	"%08x"
> +#define SUNRPC_TRACE_TASK_SPECIFIER \
> +	"task:" SUNRPC_TRACE_PID_SPECIFIER "@" SUNRPC_TRACE_CLID_SPECIFIER
> +
> +#endif /* _TRACE_SUNRPC_BASE_H */
>=20
>=20

--
Chuck Lever



