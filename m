Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEEF3AA15F
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhFPQe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 12:34:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52796 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229575AbhFPQeo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 12:34:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GGWauu001918;
        Wed, 16 Jun 2021 16:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gdfEmwOtoXmlFmeeX8cNcSrL/R8TMv6ZjqhZoPIZyzk=;
 b=vhWW7qw7DgkqRJEDxoO7xaIUfgCAFPzT9Fvh8lqamOWDaBa6omWbvvjFxuSt/8FaQGF+
 8J/U+1Jn5sKD6kjwDkyhooSBA14xYIwH5Ow1AhibyLyduw9PkdnDs5viWBA2DitQe0K0
 Wxrwp/M4H8cmZa6EX8idu/UkfHB0SEapCY+opeiES4Fzsmg3qNzp/075vhp70ZUgC259
 6Sy4ELTpFQHvj29Gfi4bdmgZz/Z2uGP/pB/VvmFhcKZOzx9MpmOOfuc1zmuinP/ZiOfd
 cM1iAcy0FW2PBXjQE+9pmNHA9tlX+IYgbTjTGuc3Xo8QaPIp15ucS0q/ZoM+3mZp0by/ gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 397mptg0wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 16:32:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GGEs0V001408;
        Wed, 16 Jun 2021 16:32:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 396wap2g83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 16:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZE6EPEq+nQoUmzH6Ois/lvHZ1rQzuRm2xmu2LlG7ekSJrm0CarfPetjLFLTqWGR4zHckQqRtMt7WeyL5i61uYYIUJXwQY5WRiWzCMuhJ04FqLuXc5i0eYckUj0D6+bZdkm8UBM/utj25mQIcF/MMicXulze7icdrQ4Nwb6cQCP3y//S5/J305f90qr/PLi74DqcRDnL3nrg1RWf9JZfz9CnrL3RHgkMiVD0HsyoDBjhET1ovlWFhuFgC7R9g/ETpOVeDR9dMXEfueqlEVmqljy4tNROAwlTRyqeoIXTSAU2mNCAoWFDaqJmNsHLDZqiDkvd0p/LpRyeU+7/xXxnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdfEmwOtoXmlFmeeX8cNcSrL/R8TMv6ZjqhZoPIZyzk=;
 b=iiDwUCLfRmy1f2IWa2neM8HSZlZPLMOKbhkPfslwRneLZ5Tyh1ZSqeQG9eF5I260otwAJl2OHwbC3hF/4ubxq42f1QsOiV3utJTN3RGh1xWjF3LtwQc3qoCgA+ws0005zNqVC9aN2NNXrtORIlWkki08mdd7CyU5OcNHPtxyWG68t4UhHbpRgiufBTTwNPwaT+ZttBvQmqysLLrXj11IshFuarIxEzKAUQON/dvaqD3xADehniJu3KSM1aTL8ZwGH0D198bzQlgnrGGt9DPVuBD/UGj2aHfJ/edI8F0cvMb+C8+fWJMNjudy/orPIBTxssPdaYdyysr3r65xAw8HKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdfEmwOtoXmlFmeeX8cNcSrL/R8TMv6ZjqhZoPIZyzk=;
 b=tfn5AXg0bk3XIcVz+q2to5cz0fZLVpknmkEzMRDzl9iFhiOT8gsMG+Cjoy82Uc2mp1YzIh5gylXmoNknQokvZtDawMv07D8amfi93av8zbuNxXoMvocmru34614rHw9YPEmtUTGjXda/pov6ClE9YURgzFlgb01hoeL9FGMR/nI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3029.namprd10.prod.outlook.com (2603:10b6:a03:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 16 Jun
 2021 16:32:26 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 16:32:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Topic: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Index: AQHXWKRU4nAovJ01SEuUWcwucjnsZasW4MaAgAAIUoA=
Date:   Wed, 16 Jun 2021 16:32:26 +0000
Message-ID: <8A44DFA1-683C-4D5F-BE71-0B94865AFA28@oracle.com>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210616160239.GC4943@fieldses.org>
In-Reply-To: <20210616160239.GC4943@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 945e03bf-829f-427a-85f6-08d930e453c1
x-ms-traffictypediagnostic: BYAPR10MB3029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB302974BDC705B36AD7271368930F9@BYAPR10MB3029.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywxOAEAWmUVzWUVhOgRikvHZqgld0wuMVk7NHsTFnRm62GBcSQhEXRljMsqiXiF0miD9/jVzbekR0Zvg8Vc6kssT3xcYLAz1iNGgCjPBGgBtjURu68cy0j2u7eief5AGYWbY+KYYGZcWmIB4MKrzF1HVQzEYlzpL/2QDyopydOFcxUzRecR5zbhFQaL/LdHK5BA2VauWxBnsWnxxO/otz7ws0C4+y9WcZuiXxwnRtbPsOfPDOlW1thf/07JGlQxBbdNvZ/urqjUbsPaEzmwIdZ6HvDGEjgdoTa8c9+oUI4lO5mF7U9uVgHXaH3pwb+2tH223+IVs+bDDuSW3CBc4+U7w9VhCDfUyu748hMvnsn05VKlh2fSaE5RZwSYyo7FG/3qvFxytYqFw42gMKQ8Ya8BPC/CuEhpfInfDLn4qFsAVhagYU2FBG+wuztox6a6GUqWpq+uMI+dKkf8hDpkVjlIDRt6d9Et7hFmlncJTkEc2vMahYXJj4zGnQQQFzxapAy+FB4bLS0khC2+BK+qJxfWtLpFwEQqwUtcwyNiw95MZEMcetY8LHPmjFlovtYpkQXKkDc2c6Q5uXsYATpo6elg3VG+31X3yXU8yK0OPLtlsGC/O6wzMAUU78vnTZtAk9AuTj3AG7K9J7fcqLblt9rYdCPueOLHPeB056OocE8U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(316002)(54906003)(6506007)(53546011)(186003)(478600001)(26005)(71200400001)(8936002)(6512007)(6486002)(2616005)(122000001)(36756003)(38100700002)(6916009)(4326008)(8676002)(2906002)(33656002)(66446008)(66476007)(86362001)(64756008)(66556008)(76116006)(66946007)(5660300002)(91956017)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lBRhR/4/zPLIpZB+Jtc7lhMRG6r9EeM3clUjnPuRAWxAGmf2n64jyRWBMFKN?=
 =?us-ascii?Q?eqsnMdQTnPhMk9z0XPtQYO1Tei4z6l5Sn5NC3bgd8jvcAbolPtc9TUB0NhqC?=
 =?us-ascii?Q?O2JiuZRZfGVWFbJxq+2D9jSyLkuOFvE/OlUe68+Bu819do0+vpCUW59UaQ0i?=
 =?us-ascii?Q?mSy4cx1UHDUsksaD90FekvRlmC1ZgXnlHxE0iIA4RJgGtshnJZLS+T0kNVkE?=
 =?us-ascii?Q?rs2DbPd7muBhqDz7Tn/zszZ6lwsBokf9U8cK9co9ARJQmbHKYV+jBBLiXFuJ?=
 =?us-ascii?Q?6C9zPaL6d1yPCAgBEU2EH57SXda4hOmopDzpTOIBjYvIpGYJu/JoVI8B/P6F?=
 =?us-ascii?Q?VVDgBT+GphvbG+E/1qFASnHfic+WllF7z7heMaZuhpsy3M91gCIett+UXw0O?=
 =?us-ascii?Q?1NRoVyBbFZwtv6Row5WoIC5jnbMMQ5isVWqK7i7Yza3tZxOBfZdQpbB9B8IZ?=
 =?us-ascii?Q?QrG9OaideiJ/hGmsc1PSNF6TtHrWrcjgcc4kjsMvKJDYndhhOleDBbmJAEW8?=
 =?us-ascii?Q?rGid4F6+Ovli/mcsKw4EK2UYU4akHQhr11PDiaWbb4ozt3iApR5aNa3qu6Ve?=
 =?us-ascii?Q?d+ov0sRe4nVAarL+G69Z3hCIQ4EyICknNUd241BkvexUhkk8HskGH2gR4g4X?=
 =?us-ascii?Q?TYv9b+XUpyw8/CJ+IFUTNXbckmIR34pbLVPikgRyijZscR90ZRFKDT55zV4L?=
 =?us-ascii?Q?c/sKQ7I6v7Y2aA5my2+ei1F/rCgVW2NQ75QN+NdJEN2SBSIcVWkqJfJ7Mh5n?=
 =?us-ascii?Q?HI2+tb8n1ZWJgnjqB+lhs7t1K1r56ChooIYToApGNWUDAl16d4TlWouHnM/v?=
 =?us-ascii?Q?B1iwyjgFld5c2ztE8byzEUsUROq31BhePpaVXiDAHRf443p9T0dokKvpCyE+?=
 =?us-ascii?Q?elQLJCB3SOy8cztMXL6aIm9EXRbtRbSbsv2rwjC9TcgSJbREiCQ1DJHC5bjc?=
 =?us-ascii?Q?vUDpcgz/NLdt7l212UgKtnAWW+Z3pNAWVIiTYXpbzs0OOq2DJIBDNCdGxm4w?=
 =?us-ascii?Q?YVrBj2pPQMhSzMuon19LfjCRFUtQwyTQopfGsWrp09qVW8zYar1h2+SvnQXN?=
 =?us-ascii?Q?AVjGY1JUlUvOXRSdM1bD5vO9ZMVJ3nLcW9CvS3n/uJG4frBfw9l+nFcYRFbB?=
 =?us-ascii?Q?JWKqDcp1IycZL6N7Wv52xhjrtLLT+cvX6vdRZVY+N+xDOhdHNMXUFLn1AHVT?=
 =?us-ascii?Q?MgG7vtF4JShvne7YadiXgSeRMf9zEGqq09ZU4FfDxQsDa+tzSCTdBtffyf/4?=
 =?us-ascii?Q?1GgfgZ01v+MZLj68gU3dGEC7uWm4v7cJH7lrYgWArzAkivLLuxZMS9NTRF5n?=
 =?us-ascii?Q?cJ01FQijygo3XP8acB0hlxR4?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21EE361C42341948B694ABA1288CA73C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945e03bf-829f-427a-85f6-08d930e453c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 16:32:26.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JNgvW7FZmYDifkzG0zpNIUpakHW+foAxCP9SK6ER9gjnIyO/QTMJDrn94Z6h+SfOfYM5dW+uRIN7sUuZ0/3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3029
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160094
X-Proofpoint-GUID: hGzwBCL3OCwg0wVIFfDp0JC26pjYIMTm
X-Proofpoint-ORIG-GUID: hGzwBCL3OCwg0wVIFfDp0JC26pjYIMTm
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jun 16, 2021, at 12:02 PM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
>> . instead of destroy the client anf all its state on conflict, only dest=
roy
>> the state that is conflicted with the current request.
>=20
> The other todos I think have to be done before we merge, but this one I
> think can wait.

I agree on both points: this one can wait, but the others
should be done before merge.


>> . destroy the COURTESY_CLIENT either after a fixed period of time to rel=
ease
>> resources or as reacting to memory pressure.
>=20
> I think we need something here, but it can be pretty simple.

We should work out a policy now.

A lower bound is good to have. Keep courtesy clients at least
this long. Average network partition length times two as a shot
in the dark. Or it could be N times the lease expiry time.

An upper bound is harder to guess at. Obviously these things
will go away when the server reboots. The laundromat could
handle this sooner. However using a shrinker might be nicer and
more Linux-y, keeping the clients as long as practical, without
the need for adding another administrative setting.


--
Chuck Lever



