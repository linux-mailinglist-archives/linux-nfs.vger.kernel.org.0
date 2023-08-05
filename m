Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB0A77103B
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Aug 2023 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHEOvM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Aug 2023 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHEOvL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Aug 2023 10:51:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777374224
        for <linux-nfs@vger.kernel.org>; Sat,  5 Aug 2023 07:51:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3758V3fa025694;
        Sat, 5 Aug 2023 14:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6AMNUU6aNuOh2aGJKPK5epJj2wShc0tVcqwlKD2b8uA=;
 b=xgXRRprJGZuxilCm4VraD+OFjCy7bXTFcZO5wADsF4n07TAkB60HYM0Lb8dEUi8SVgxh
 xFzMJ6+iM1aaHgk8TyyMS4p1Ha2s8nf3gm3GGURmLiApWj+GB7rT9cYsQc4z4OF8rIYi
 liQr7c4lg6xBpR2yBc9a8RIEreYH9hJvIehqGXpSQf21fyB4uFwK1nQFng9O9SWF0pLk
 70EEf7nXfD5MPg9k1Kjqtwecymqj5NW7JYcdCOYfKxoGgKBnMJFp2DsgEMbkIG8rGCfV
 2JzEm2zn0vaO4bVAMPSxpK8CwWoCSJB89sCxP25ElTy5Zjjxm4SrbKIKMj6vFL/yYji8 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eyu8dwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Aug 2023 14:51:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 375AGt2w031196;
        Sat, 5 Aug 2023 14:51:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv8dkun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Aug 2023 14:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0UOBGwN6/Z9vMd1yrZ+JpMJ+UNZ4mT00yKLYmOhCQ0sMWguwjO6Hm31cXkDGlfbh10tCl6L/0gxfE0zSn/bSCDngI6PTLwjucce9f9zapHJCMQZwWsSbooGl57rilZiO7qn/fk/XfF61ip2how+qTsBEwZIC2ZrHlU9a0GQsGWnzd0MPaLiPXDA6U2GcA/NoWKEx6zqohZUAwEwy3K6z/PkvaLA4MVWoNgowNMflocstozrNfS83IQTesO6ZJ+uG3J0Ghv7LeYxQq1GvlEjj9KcgV4ue27uA0ez9Lbk5NuvXCVmm1d54Asni26BEmyhu8huxTl1B2XddHumkyTu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AMNUU6aNuOh2aGJKPK5epJj2wShc0tVcqwlKD2b8uA=;
 b=X1I89P6knzqxXKBRSLspA0mtRsexq+MGkKmYEOBlT2HQHwfRwAFoqu719ji9IjtTICuUQ3Sl8TUQp2AfKhDnyXWhOiUJbbcnmcCfnuv+qd18k/KhyPpSbhO/2nee67h2JwM96LToaiXkpJcIXIkLOX1JLXZUTWbejqfn1bYmePaWbhWbAkVaug13bOX/upoVeXERhX9YJT6A9+PV/zeADYxWK/iLuyISyr8FBNJlkR43r9Gs95m9HP4QdgUOCUsuLP3RhlwrKrVXMj2ysKYD2VH1SLc72sM5FPS/6Labl2W3RAKXywj9I0wzNpnh+GSu8or5a6dWjJoOm/Vti7sZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AMNUU6aNuOh2aGJKPK5epJj2wShc0tVcqwlKD2b8uA=;
 b=gj4DTFI5VF6MY/wSTYftv56Bhe+yO3b2fRQ7FUDsPUw/6Mo2c1GNntnllhxRHrlmDnlda5ue6xytlMqLR0UMb8kL0vlD6Ru8eLMAzDoIe7yZ99OzkKqczbDYAPL+cTHvVWwKAan2/+uW9AwgN0XDl5T01a63Kwf+QL0CO5IPPGg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7379.namprd10.prod.outlook.com (2603:10b6:930:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Sat, 5 Aug
 2023 14:51:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.025; Sat, 5 Aug 2023
 14:51:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Rick Macklem <rick.macklem@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Noveck <davenoveck@gmail.com>
Subject: Re: RFC: new attributes
Thread-Topic: RFC: new attributes
Thread-Index: AQHZxyGxCMBqf0og90qdzqr5fGHKA6/byjGA
Date:   Sat, 5 Aug 2023 14:51:01 +0000
Message-ID: <42DE2EB5-E2E5-45D6-B0B9-8C63FD6DC67D@oracle.com>
References: <CAM5tNy4d02dOyWsVk7Y-nFEyGjE=eo4nJgrap3M5DebDJz9ehw@mail.gmail.com>
In-Reply-To: <CAM5tNy4d02dOyWsVk7Y-nFEyGjE=eo4nJgrap3M5DebDJz9ehw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7379:EE_
x-ms-office365-filtering-correlation-id: 1e8c69d7-3db3-42c4-0aed-08db95c36349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQ1qcjD7qYckzoKjFSuDkU8z22HYOco6HYlhm9MCW5lN1+3zkXMnr7Ubx8em/B5mueB5rLklrfVbBS2xdp+6RwHMIHBniteZESI1/flSWgGUaU/O3q+ztZxPkxQ/soY8eW19YAbI87OrMIXw5GfwhYB+otBFcFryltm/EefBGN9LZFskBKu9AnukN6WhR4565tIINaU1UYcKoBEovtI4KkqNKFm16gJszrelSd59HN/tqulkRbHvwd9PXy2SbyOeNgi5buBtt5yETiigers0Y6WU18UbkhjC21G9CinF9E9Y1GOLaG5mqCNMBtYPFF+tFv9EoKqbdabdv1kvyZVhJyis1YPNY5WhqXaquUa3vx+Q6izhwO/SROOjGIL6Qn6S0jOXeY1JPqszUd6wFZ2wkG++6P5fzKRgTLcE6Wcihm+vc6PQWhPtK98qYWpvbvYHNVUe0jlKAZor1BYgjsl2kMbnKQ2jqhmfw/7JYaeLrWIr3tDgsQFgRX9DcGh65uA8QAjYSyIV0vykRpA06yQQVC6sHoU4VDHmFxZcYIRKZ0ckGKief8BA212lzAFtCIrtevjLDpGUObNuQVmVnGfJUhFYeyhnpLBwcl5t2Vai+QMYLz5ab5PPi+XDDAjjQw64j8j18HjBQ+zWufj0Y6gHUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(39860400002)(136003)(376002)(1800799003)(186006)(451199021)(8676002)(8936002)(478600001)(36756003)(26005)(33656002)(6512007)(86362001)(6486002)(71200400001)(316002)(41300700001)(5660300002)(64756008)(4326008)(66476007)(66556008)(66946007)(66446008)(6916009)(83380400001)(54906003)(91956017)(76116006)(2906002)(2616005)(38100700002)(122000001)(6506007)(53546011)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ff6cfN73kSTin4sgBh5d7FsRVE9QYsgLyVm9FrK4/0PcdUP/w64WUgBYiD7M?=
 =?us-ascii?Q?sNFjseCREuqBXyUhbpQUYtKMCMWS1C6Tw+gw4dZhUO2K/ts22Ne/UhigGx4R?=
 =?us-ascii?Q?rXrQAF7Y6HXpAQuIVNECA7tpK3GlJLph/2vo2YroO5/rlG0YKKKSk26uFkYw?=
 =?us-ascii?Q?KggG7Y9jIFKyt7I7kUBGk481tv1hK1IPQ/1vXYzUeanha0q0ut2oWaJ1Fy9D?=
 =?us-ascii?Q?Kt5haE+6ogS1KrOMgJTJyYLEnY0QUJqo7tyvknUE/lmeY0aS20l1CcoaVvy2?=
 =?us-ascii?Q?DUAEFJ/hNOlbnnPZxjGu9YhKRs/gsB/7hFD66Kcx7HTXlzxDBLzweO/94rkd?=
 =?us-ascii?Q?Gxh48EP3k9bhp07lxDwumTGQAaSVI14s6RlFKWImFK0qzHlAvbOD4Xf9f3Lj?=
 =?us-ascii?Q?alLr9laB04K3Uz5kuBQsNpPPJvzZh/5/Za+uIx+Z3rWxdMfrduIGHfkHc376?=
 =?us-ascii?Q?O9OEkmfavQwqoTZRcB7N6TWa8yVnPM7gSqxhv50lAj0d3LZB9+Wg6/BWWW7s?=
 =?us-ascii?Q?SmDC8NbiWuTa3wTGRSfHJOINZHNoNXHQLJhaPfYiqI2oGp7egRxLQU6SgsBp?=
 =?us-ascii?Q?OohJNpUbpGXz1COR19yM5kIi1Sp+oLCjj2lOlLXnlPhS8zRFE6+O3Q3HitZf?=
 =?us-ascii?Q?r/Z5aPyVFt43CS4d1mUj5Wz5SkVOg+7kxY432mRrTgj7rvVRb7WF0yoJE1Wa?=
 =?us-ascii?Q?UAo68UHFxTV1r3chvoTAZmmAmRhMjpKxy3NuS1GxORq7wAaQb9IczDpokkUr?=
 =?us-ascii?Q?zC1TDrxeXfgvhqG1OCRCGTxwhbD5R+5VHu8OzPRsM+ZhJDX7uAc+ZLChucge?=
 =?us-ascii?Q?s9d52dX0r3luGT5hFMyLIum3U72zWXVAoKES4EOs2h0a1J5Maj8JfKUkcA8V?=
 =?us-ascii?Q?Jbzq5HqGbDgAmO4DKujvllcZF/Y3dP/I2Ovw1QOJGn0bXydnkKY4sC0sy0iR?=
 =?us-ascii?Q?6Nwjae+oSblgWPJrQuO42f6tDdriBojGZRDedvSTb0bxMX8PCBTzsLZlwBuU?=
 =?us-ascii?Q?uIvcPYCbFLw1mt2oDlB9tFImZMYXJeeU6GUv0NVF4ziyitrzb1lMWwkhcd4w?=
 =?us-ascii?Q?aEIdW86q10UKqGtNGKS0AluVdQ+wVUqHhkYfWj2/4tlKBdiNQtMaPbALJ5sV?=
 =?us-ascii?Q?wt5N9u74anx3lZCkkHbz/8Af+ptEQsczhgMKWe+Z0OAt4ZTEyWpl9pg7xCTB?=
 =?us-ascii?Q?eXUflMjaCvVf7fOJFXI1yCM2FrIsw9/6o4jsYhSDyoBcwWuXE4j4AV6II6wu?=
 =?us-ascii?Q?CqtBL+xoO+ru9dxxNjPlXdSwxRrHiLbzg0Hw7B61LAaQx0i5X1nPMxJT2rk+?=
 =?us-ascii?Q?Fqd1vDuu02ypjk7Xer8DsK8PPmhgRF9dwgM2YrW2a7N/+y3sOUWbavhN/dMy?=
 =?us-ascii?Q?yYRdJWBEIZu64w0q66vc/Ugh1T2VuedPCmnT3v4DSyeRJggmToMFusMB2LJX?=
 =?us-ascii?Q?4ZFnzy4NOyOZT+cByUME7LY/kqxQdEoG4Py0gTl9xyiOB2nT0uZFZ9GkZPbe?=
 =?us-ascii?Q?Gb61CfFDCVnUi5Tzx3Qnot21AFHQ+B6P2NKIbY1uWi8dbatQhfYS9YLkTsln?=
 =?us-ascii?Q?6Z+LqBWGP6MBdOaGa/7Qu/GcW0j+qTnmRnlb3mgoqxD58RDWibvStop5RTRK?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D93EB0392A37434E99D4D5DABF1AF934@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: puxp6khiqNZtEpTUDiiJXPpzcqdnVoQE2xXzf8uHeTAb/t9C3JaD5gqO81HJkmKS0GEkkXncqou53NBlA3fnIL71O9yyGJ3oZi+F8mbfEHC86QiVFoZzffPnkhErru1Jx+VdCbGVuAy0rQAgCsjB3/FMEZQwwAa5iFDWeiqQCbxqLeXj+3+Ty7iDQA6y20psC9dkRHoVNawqwLCrXaZfDr3hWVoZe21+leCxbotlUfNby8/fP7NKztHBqYskjngp6GBCjbCqv501Z5VO0mZ2RXaRtD+uJL/RlXlq302+QsN7kP21a8Vv3wwCVLWMtb6uryySVBuVc82iOZlPoDY9+6vy7iyWhAsQLQn2trjqKf2ICveOMlXkUhOiaj5gmRGJuFviFtof4Ub9i+cgP2vVVudWZXG7NdVgf8EtRfvnsao3+/tR18KpaZ5XM7n3Vtq79Z4xE5N1v6bb8Yrn2KYQ8XBhgzUuukW+Wi7+SR1F2DiXhiupraTcR8/vE3+awFozOAvbIYb+5vyDR4mBUAqhXG2SeNtFYwJYvWDqEWRuJBVSNKuAZvdPg6s+RLu97V16VNutu72L6NGwDcyZiWxORURywBamIJcNXF3mY5S/9Oz/gPiEh6gVSICtXAKBgf5g6egIKVXQatIjdHrsiBTWoun4lN7XJ/msyjLzlUbUR3+IGO4XhrX6+9eFlSGQNvgvJqQBdPjBXh7rb3AmpEES72uT+bZxW8zHLkO4K7VyVLD3gJiNvsMt55f4JiQW8gjZY/RLB67RfsaXcg6iLFs8NjQYG+8/Jx98pr/yGdRikOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8c69d7-3db3-42c4-0aed-08db95c36349
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 14:51:01.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pWHUpHO16TQv4dHbPxrD8QFzt2UKVCPf8Z+n/oSXyPHze3aoL7aj/BuCOBIuKji7cgvbRf7tZMmUGr2Odbbng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-05_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=790
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308050140
X-Proofpoint-GUID: Uudhu-eC0YUsi5-w9CyBLm5zEtcGUCVq
X-Proofpoint-ORIG-GUID: Uudhu-eC0YUsi5-w9CyBLm5zEtcGUCVq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Rick -

> On Aug 4, 2023, at 6:18 PM, Rick Macklem <rick.macklem@gmail.com> wrote:
>=20
> Hi,
>=20
> I wrote an IETF draft proposing a few new attributes for NFSv4.2.
> Since there did not seem to be interest in them, I just
> let the draft expire.  However, David Noveck pinged
> me w.r.t. it, so I thought I'd ask here about it.
>=20
> All the attributes are meant to be "read only, per server file system":
> supported_ops - A bitmap of the operations supported.
>     The motivation was that NFS4ERR_NOTSUPP is supposed to
>      be "per server", although the rumour was that the Linux knfsd
>      uses it "per server file system".

Before crafting new protocol, we should have a look at server
implementation behavior to see if it can be improved in this
area.

Is Linux the only problematic implementation? Send email,
bug reports, or patches... we'll consider them.


> dir_cookie_rising - Only useful for directory delegations, which no
>      one seems to be implementing.

We've been talking privately and informally about implementing
directory delegation in the Linux NFS server, so this one
could be interesting. But there aren't enough details here to
know whether this new attribute would be useful to us.


> seek_granularity - The smallest size of unallocated region reported
>      be the Seek operation.  FreeBSD has a pathconf(2) variable called
>      _PC_MIN_HOLE_SIZE that an application can use to decide if
>      lseek(SEEK_DATA/SEEK_HOLE) is useful.

I'm not aware of a scenario where the Linux server would provide
a value not equal to 1, so it would be easy for us to implement.

What would clients do with this information, aside from filling
in a pathconf field? Might this value be of benefit for READ_PLUS?


> mandatory_br_locks - Byte range locks are mandatory.  No one
>      seems to be implementing these, but a client needs to know
>      that mandatory locking is being enforced so that it can cache
>      data correctly.

I don't have much exposure to mandatory locking, maybe Jeff
could chime in on this one.


> max_xattr_len - Allows the client to avoid attempting to Setxattr an
>     attribute that is larger than the server file system supports.

Can you elaborate on the problem you are trying to solve? Why
isn't the current situation adequate?

Again, I don't think this would be difficult for the Linux
server to implement, but I'd like to know why it's needed.


--
Chuck Lever


