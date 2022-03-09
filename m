Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707984D3A6F
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 20:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiCITfH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 14:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiCITfG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 14:35:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314AA1A815
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 11:34:04 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229JObff032285;
        Wed, 9 Mar 2022 19:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=il9oaQCC6p30rJQ5aOfIPiW2MUvKMPLyF035EPD9XqE=;
 b=QWnQEl88opxZZVn/ACX/uPnpKA0jjsy8R9YSEPy8cqNt0L6hUsAZZqqlmTgMV9JqbW2V
 J3FwG8+vYw3r7W3S275LB0nhyRaQBh9WoNcqd7h4+gXDk3FAILDumAMgmNAjq6O2gyR4
 3qGNtC8TiPWGYFem7WcUSZsEWo+k2TGcKgaVMbkJsvOJCLzQYHo4GUSrR2aqvXrDpUNV
 BLKrWsdVHKHFBiOgHZ75yFUenpimq28U/Y4MUZh60OqdEW78O3JnOywiT/etTHYTr7Qu
 Jmagu/4PDe+ysujg7BOhW+NgBpFkoiGANGNN2biSyP9cDHHP/ERO8IuZbDfuyzPmXEiy Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0u5s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 19:33:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229JPhPD052067;
        Wed, 9 Mar 2022 19:33:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3ekwwd0981-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 19:33:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q47nbsUy08aNoYI+c7QzoXkDo6z20lHiGVFkJXg17W1Ec44Udu9gxJKh8Xehc6ZyMOdJUmPsZjSilXl/1YG5HeMBIORto+DxPPMlRn9PTXfUERURzlKerHCrPYAwr9wLLYtsCtFzAuGCjXUMOuGC03uDJt1+g+t3AUh3WM2EbiPQKY4azykbjb1YTQ8hhlS46dMqJWwBeLyoTMtt46+5Ac52EibW2kVp0K7O390mvLTvuAo+qdO6YQSzX5+aK0Rs9n1orC7+lFUTB+FHRcJWaNVmBbdYMAC96IA9IUN+zp80RFjGVmtYHWFHWcCNwNVN3nhtmLX4ocMHkBlwzV4TFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il9oaQCC6p30rJQ5aOfIPiW2MUvKMPLyF035EPD9XqE=;
 b=J+pFqNiRdVKSQHcCOpRpodlZXeS5AyKxHKXSu0mNxuJAwnEspOtwYIIlVPnwBGzkhxExb3VTI85LNOvxada1xk/jEZlwNR85yq8qMIGwvphdmAkDLsAhHwDA+laQGwRmxGUMUgRJXb1JVkZJu8/AzV4HhqobpPIm0grvEbzNlKUaoZytYm8G0cbcTEWZlUPwcKAigaQxTAma1/eEDvC1U5V0iQOs37VOcd+OmqhM7xhovTAo7qFwdorlqI2eGfpf69hB6huwbbzys2bRM+v74fEm9H/1QqGynPt7+ARuhTBZ54lGCV1l5s5rqG0TmvuSCOa0irx/JobCHYqrOR8Oow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il9oaQCC6p30rJQ5aOfIPiW2MUvKMPLyF035EPD9XqE=;
 b=vUGGw/V/Dor4uYV885ufiL8SvJ7bPGkJNBjEq13unFhyPWnV/C0QSS7sEsk9xHvkzCuM1mGjeG+hhdLU4u/9wGshnPMuMNbR4EzUc5SQCae+oM6KoMf0YimOEUBO8ZWQ2zygPsLfDzw2t8pCtmajOw/a+a0cbpDfj5WEXXihTNk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 19:33:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 19:33:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thiago Rafael Becker <trbecker@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "tbecker@redhat.com" <tbecker@redhat.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: [RFC PATCH 0/7] Introduce nfs-readahead-udev
Thread-Topic: [RFC PATCH 0/7] Introduce nfs-readahead-udev
Thread-Index: AQHYM+NTwjsnxhxv6kKmvizZpFyG2qy3cW0A
Date:   Wed, 9 Mar 2022 19:33:50 +0000
Message-ID: <305452CD-0055-4AB8-8203-76D5AFE1C560@oracle.com>
References: <20220309182653.1885252-1-trbecker@gmail.com>
In-Reply-To: <20220309182653.1885252-1-trbecker@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d151e8f-4864-4231-2aa8-08da0203bd4f
x-ms-traffictypediagnostic: BLAPR10MB5316:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5316999899EC1A55126914E4930A9@BLAPR10MB5316.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aedtTQwGOcu6mQGP8Ye1nk7kXslEz+KxTDXIc1Y1jcW/9hT+TfkxwN8PW5bps/jzTJjCL9ujOwK1IiXI7RjiZzY+O4W/GusMvp9nbM6oV0fLXkARG7ls3jugVij/ziThqgvHEGjxxErX48Rpfk6qUMTZx7PjRUkwG2wdrghUWVvTxA9sicS5dNDvpRU+Zl//RmKHEpV/s29pCKJEoKgY4SKkmX+NYzawYzEzf/uiCOXVS8ek4cQcuGUD/mkioyulFQrGROslmo/+NRTbZvNjMELr1R477LRy4QklTF+89hBUSwwCKs1K6P9opdAdq9jBAiJ481W+jeQmCvmOCcS0ALp+aBTmszX82YlbQsijuVjEEkppFpRSPOD2q4Q4baYA2uvoepwgJ1gKu02rDDeMpf23TzfR2eiIezK6pqbhsGKSmNqOw32nqlJopL7P+6RAKuc/SJ+cebi35yGLpd/CF3ZTyIR60kmwg7JHJ+Deza0oaeswEIZSIs8DHN6kwH3PXlzOI6L3rHgYOo/gomeg6JO5qrDbwG8tjanbtqOBse1wggn35uLI5eJXzq+nRZHrHxXODhTZu1XE3Y1A42tdpjBG+ERbbo/9i89ANtdEHi+pSQKFElu3eJwY8IUTESEJqYbTBhOiSFy+6o0UdF+ljqILZ5FCV1Yc0amX5hIXQyvG3IvPOwpGhKZOlVwuLLOl5K5xKPgC5nC7w8KBj1ycZfM6qSDNPzZnt9Vz1BvYS8vd0tF8tPAkNDLlYhkmNdCt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(53546011)(6506007)(508600001)(2906002)(6512007)(8936002)(5660300002)(33656002)(86362001)(316002)(6916009)(54906003)(122000001)(2616005)(71200400001)(38100700002)(8676002)(66446008)(64756008)(66946007)(76116006)(66556008)(26005)(66476007)(4326008)(83380400001)(186003)(91956017)(36756003)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?961AM+URTtYlX8JMEMUIxp3U9zPUMKALxGCVx/tWpdJ5O6HXIHqFwlvP/9Ci?=
 =?us-ascii?Q?MErg7yoXWqt9xnhC2xamhMhcZcXOv0Fz6zHkUXKHECi3tVeq+ZSfAUOeyomq?=
 =?us-ascii?Q?vZ1l6qAIUuILEMDobndS5j9tQu+zp09hxMAyJwpNsgwnTKyNs8YT/wI/LK5K?=
 =?us-ascii?Q?yJsvS5ahxNwJ4Eiax1DDfTXug3aA8SoRToZEMYo20Cd1TymTJEEu+/tVIbnq?=
 =?us-ascii?Q?Quuy4QpIi0rCm4Tnt/f/egHyY/MKP6rRiRchwB4wbv9yb+rUlHCze2p/mMzW?=
 =?us-ascii?Q?gaaQQdxlfpXoh1nLoxB0aPIbbaDSJJOvS4Smv/ck2GI5YvzsksncnCbdgbRc?=
 =?us-ascii?Q?Bich1jZbCrtV7h9GLP/wWYZ3W1pmKapuPIN6mPCGrz9phUtXtu1e2zsd8ITv?=
 =?us-ascii?Q?Z9d044GdpCPsx1rpBSKKBZ/FZIEHKCgyjDNhFv/yqP9/froShvB/TwELVaki?=
 =?us-ascii?Q?e5OcvGrs+LqMijO2qJ5fEVq2Z9x8tR+26NoKrLQ57nAQvg11MYoAnrGeYKhM?=
 =?us-ascii?Q?u2vuQJsLnrpji9/zZgM344MxDey10dnLJkxySQGTCoAnmSwE7pP4th4mjCW5?=
 =?us-ascii?Q?uAOf2HK4YTL2H7Yu0O1Q9Vp2VBL5zxNkeA8/KMENVTWvhkskU1bhEu7n9vsd?=
 =?us-ascii?Q?yIw7ji7n44wTfXEp7r4d1ZT5885Urgpuu+oaoeUZ5D7XaWUUBw5hylappt7E?=
 =?us-ascii?Q?+ln7QqvIMRca+2g48v6j3HMnFzE/p8J4fQ8iBf57LwYvi+XdCm6xOyZjW55S?=
 =?us-ascii?Q?LX5rSxqVBWHLMsSHMnGKmPRDYLoudYLwHpvgJGOM70FoV8KAzXZ/G6x0W8XP?=
 =?us-ascii?Q?u/4wdoR02cy2xoidPHMW2i3TG0aKe0+rg4vOc+HCyqcZrjvGfBVjsxZvqYPY?=
 =?us-ascii?Q?ebx8KABShY0WLKfc0VmHXLDVMbC2Y2vp2+iomMjeDTavGyVSNIiSu8fp/npk?=
 =?us-ascii?Q?f5WrOXSVnVfkmO6SuZ4yDC2lIPBfrSDc0dotIokFmEHd2kGRneNCwELKbWAP?=
 =?us-ascii?Q?tmkeg42WwsZAalI2dnsdpPZnED9q7JH5VoGsdqHMeI90JFrKIv6H4T2Xg+Tf?=
 =?us-ascii?Q?oAUOH0A/GOa30irgPMCFV6hQdF2sVTLq95HCe/NJvJw8TkPvJMc1TFKb7F2j?=
 =?us-ascii?Q?ERtWwKk4oVa6MVooGSGIcA9zBFu8zcLv7/fIxMokvIV3odiERCDHku2DzJSI?=
 =?us-ascii?Q?76P972DZI48egyzMwl08iHxFEJOR15OyB/dcsO+phr2VWtYV6fi+W+Ub91oq?=
 =?us-ascii?Q?hLy3EZup8z7wQmu9KNFINJSch6v6O7opTW+dMjZg8HSGUQ0S+C3EHnvD44t6?=
 =?us-ascii?Q?6LtY9fxoQg4AV76JS3QhxlLKRZa5AuviZRH/NY/iLv+2F9P1y58k94o1gnzl?=
 =?us-ascii?Q?mMNMsS0E5iNE2Hl49dIyZK8c9SnGYyh099ZiAAbQbonVl8zoMtzOGkvU3FCP?=
 =?us-ascii?Q?Vnp4Gn9+2Ra4CGwPBlgC5VFKbI1GLn4k6FdJRAPH6/yHBWGyBrKSWZR2F4BU?=
 =?us-ascii?Q?sXeaI9okw+ty8NxUZjLmvuAMftZfdFa86GKTv3eTnIxQSrMtXUeveNBOGQcn?=
 =?us-ascii?Q?imi+4IZ2R9/AKjXiGNr3Skmz0yhVQd6jhB/xdDmJ6cA+LXQl/4zlqGX0ofy6?=
 =?us-ascii?Q?dVYeCoa6rwsXONw9RyiFTCk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <404108667374FB42A41868982C10E353@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d151e8f-4864-4231-2aa8-08da0203bd4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 19:33:50.9961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbPntYVrGMxlbcqRgNf+6NzO0wB95UekMqOwJM+Va3mssepBMp/1Q6kUry0BnWVKh5IbGlxGJqLqlQecN35bZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5316
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090104
X-Proofpoint-ORIG-GUID: wzWKwPstaetAxySNO9kOJa1lYp-YMazu
X-Proofpoint-GUID: wzWKwPstaetAxySNO9kOJa1lYp-YMazu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 9, 2022, at 1:26 PM, Thiago Rafael Becker <trbecker@gmail.com> wro=
te:
>=20
> This patch series introduces nfs-readahead-udev, a utility to
> automatically set NFS readahead when a mountpoint is mounted.
>=20
> The tool currently supports setting read ahead per mountpoint, nfs major
> version, or by a global default value.

Hi Thiago --

Your cover letter explains "what", but it should also
explain "why". I don't recall seeing previous discussion
of an issue in this area, but then, my memory isn't what
it used to be. If there is a previous thread (or threads)
please provide some links to the threads on lore.kernel.org
in your cover letter.

Good "why" information includes:

Do you, for example, have some performance results that
demonstrate a problem and some improvement? Are there
one or two specific use cases for adjusting NFS readahead?
What are the requirements for doing this via udev versus
via some other mechanism?

Having that kind of information helps us review your
patches.

Also, since this is a client-side tool (IIUC) please Cc:
Trond and Anna. You don't have to Cc: me, since I'm a
Linux NFS server maintainer.

And also: I'm not sure what Red Hat's contributor
policy is, but do you need "Signed-off-by: Thiago
Rafael Becker <tbecker@redhat.com?" instead of your
gmail address? Just making sure all the legal p's
and q's are dotted and crossed.


> Thiago Rafael Becker (7):
>  Create nfs-readahead-udev
>  readahead: configure udev
>  readahead: create logging facility
>  readahead: only set readahead for nfs devices.
>  readahead: create the configuration file
>  readahead: add mountpoint and fstype options
>  readahead: documentation
>=20
> .gitignore                                    |   6 +
> configure.ac                                  |   4 +
> tools/Makefile.am                             |   2 +-
> tools/nfs-readahead-udev/99-nfs_bdi.rules.in  |   1 +
> tools/nfs-readahead-udev/Makefile.am          |  26 +++
> tools/nfs-readahead-udev/config_parser.c      |  25 +++
> tools/nfs-readahead-udev/config_parser.h      |  14 ++
> tools/nfs-readahead-udev/list.h               |  48 ++++
> tools/nfs-readahead-udev/log.h                |  16 ++
> tools/nfs-readahead-udev/main.c               | 211 ++++++++++++++++++
> .../nfs-readahead-udev/nfs-readahead-udev.man |  47 ++++
> tools/nfs-readahead-udev/parser.y             |  85 +++++++
> tools/nfs-readahead-udev/readahead.conf       |  15 ++
> tools/nfs-readahead-udev/scanner.l            |  19 ++
> tools/nfs-readahead-udev/syslog.c             |  47 ++++
> 15 files changed, 565 insertions(+), 1 deletion(-)
> create mode 100644 tools/nfs-readahead-udev/99-nfs_bdi.rules.in
> create mode 100644 tools/nfs-readahead-udev/Makefile.am
> create mode 100644 tools/nfs-readahead-udev/config_parser.c
> create mode 100644 tools/nfs-readahead-udev/config_parser.h
> create mode 100644 tools/nfs-readahead-udev/list.h
> create mode 100644 tools/nfs-readahead-udev/log.h
> create mode 100644 tools/nfs-readahead-udev/main.c
> create mode 100644 tools/nfs-readahead-udev/nfs-readahead-udev.man
> create mode 100644 tools/nfs-readahead-udev/parser.y
> create mode 100644 tools/nfs-readahead-udev/readahead.conf
> create mode 100644 tools/nfs-readahead-udev/scanner.l
> create mode 100644 tools/nfs-readahead-udev/syslog.c
>=20
> --=20
> 2.35.1
>=20

--
Chuck Lever



