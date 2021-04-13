Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC07835E27D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhDMPRk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 11:17:40 -0400
Received: from mail-eopbgr750133.outbound.protection.outlook.com ([40.107.75.133]:50190
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242494AbhDMPRj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 13 Apr 2021 11:17:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNX3+ZPo/4SN8Y9ZiUQfOyLZw5iXXB+J5sp15qu471YgV62biWe8nUIJsIZp6G+lqL09HPvKpHTUlAzeUzROlKNTx3C2scDSdBI7qmA5uiNE95jIQmhwr4ykIuSMzdQkVl0mQcH2FI3y4ItBjgLhGNszt1Nv2zMrqmDf8bQ7kifVtXsPf3GDV3Cg7b5jdfc/xW9a92Mhr6YKRCf0uxqWnrQSkpkyNAMJNWT6HHS8Mkh0VT+VMpHbk3lkDj8eVbljUKFrIHHD/wJyCt8eN3/eZqyg2o5WzlRjPax+ISRFqz1J29+BpPXVBrMzjQoNveN1Wr6kFXgMPiywCv/y/7xCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isS9u4tHZmx0JxpnhjGHICE7kPKpH9k4a3/qieE7DsU=;
 b=CuAFkPG3/3PpTzth7fIVRNTQb1u++/CUityTlTLi9jWnoyW3cH7KV043SRPGw7JxKSt0pf/tY+cU4//zqL49rDGcF4RcOAc/8R8XAOx9u14c/cWFMZK3zEjnxwRBSqPI2pNxt687sPWXg6IvR8n4sDzvWrwsC3VwhxLqIe6CaoFvNnAgkqT3335wpygy/ulZ94p6uqUd8T+dRQ15/33FANWnGrbSQfdq1CU7QxP/v/r1jrhF9G5/rsqQf7R5X1nEMecvD5nC7dCRXiqYeQ5UffpXayrKDfKE2bLp8i6mioUwNhV1PAuchgDpmWRlT1HDHEZaVxsqqk1EMVnkTxPCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isS9u4tHZmx0JxpnhjGHICE7kPKpH9k4a3/qieE7DsU=;
 b=eaoQXWocEMr86fHzlPNGjZiu27ecmwzEgDbypTkFo/2lKPUaq4PYwLuQFm0ibwr072EABIXwAXxCHmhaIZBOQn5YrnuHXwrOKKcM5G2+IqIsiFKMDb4tfiuYErsFuB3SGQltMFslDZoHyxY5Z6KXaur3N+cspGx4Homm/DiaQXc=
Authentication-Results: math.utexas.edu; dkim=none (message not signed)
 header.d=none;math.utexas.edu; dmarc=none action=none
 header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by MN2PR14MB3342.namprd14.prod.outlook.com (2603:10b6:208:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 15:17:18 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 15:17:18 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: safe versions of NFS
From:   hedrick@rutgers.edu
In-Reply-To: <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
Date:   Tue, 13 Apr 2021 11:17:18 -0400
Cc:     linux-nfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Originating-IP: [2620:0:d60:ac1a::a]
X-ClientProxiedBy: BL0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:207:3c::18) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from heidelberg.cs.rutgers.edu (2620:0:d60:ac1a::a) by BL0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:207:3c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20 via Frontend Transport; Tue, 13 Apr 2021 15:17:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5489ff4e-e029-4756-f4e8-08d8fe8f3a69
X-MS-TrafficTypeDiagnostic: MN2PR14MB3342:
X-Microsoft-Antispam-PRVS: <MN2PR14MB3342CEAFB3091F28F93072A4AA4F9@MN2PR14MB3342.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9meiLpgHIJiEw0H7hwr8yW6Fs9eDxAUIpXPRh3LpMFyl9UvyTbGZzQYsUC+6DJ4R8dWuVo0mltjGnM2zFaDkIh1OGOqe5st4YtQJaO8LU8qx8A0A5SGi/GY2LetwBWqm5h3X6r+aaupZi9tBwhG21+SKskplbwkdqcYYHq3mOu4OW6CQHqPcDodyD5i4SR0ShJ2/c79iPWE2SwbafsKy0mj/rbxik8Xx1+qhyzLXCFdCBBzKf9qMaYJzClRVVTraTYHQCYl1QhashcBQ3uR20L87ZGBNA0CZPTioeo8M9bx3gUVDdB0JfUidi3o08fvV5HA8wa3vC/h9JjYeufMRxfyCiutZ9IEBPkDu5W09zDaAk7+lsmrAGNEybeqHO4PrBoFOPuKtvwcsM5qN4e8huB/p2PcajrujPoGdQrV8vjEs9MTMjNa5bkcOygREUt0d1lRrALs21lwRbbat6eCJwfINnoSs49+RezJLEzrbo3Ajc98Jh2BuD/QpTuKG20L2rY4Tth1JqfhGmuPYZREGua9ZR2gwyDAUPGG9MfTqU72AgUXae3n5hLPudXTmjdoyHs82JBu+FSyMhOcs8NEJvPmU0Izk3wHiGTDRjlGcglIGxCz7YxLqdRRPVRzalVf3CrVs0dBjbHh46VZGFawuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(33656002)(3480700007)(2616005)(38100700002)(66946007)(36756003)(16526019)(186003)(83380400001)(4326008)(66476007)(316002)(66556008)(6486002)(2906002)(7696005)(786003)(8676002)(5660300002)(8936002)(86362001)(478600001)(75432002)(52116002)(53546011)(6916009)(9686003)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UUhDQ2pSZTMwNE0vQ2xLc21YWHhyaE5lNmdDbHhEYmVub3pzMmhLRTNETERv?=
 =?utf-8?B?c0J2ak5Fc2loYkszZ3pOVWJNOWxtYXJEUk9ma09XMmNOYWt1TmRWclRWMUNa?=
 =?utf-8?B?bjE5cVVrWnJ5RzlVRDM4MFMvcmNsMmhPQXE1Y2lPSGJkZnFkZkVRTm95cndK?=
 =?utf-8?B?K0hBTzBRVThLazFZL29VSElFT2hFNTJpd0hKSmZ3emNRL01aaHRYQkN2cFlK?=
 =?utf-8?B?UGh2WEMyT1BiUGVwMDNVa1QxWUVNb2xiSitQN3B6b0J2cm1BOUx2VElEcnhM?=
 =?utf-8?B?WFFXbDYyU1dUR2oza3A3VWlZVVNybStqWnIySFZ6UzVKZERhZWR1SkNZaWd2?=
 =?utf-8?B?aVBZOFZhRkY4eUlzSWRMc0J0Y1NjNTU4eHo0RFNhY2cwWGNHWWppZVFmQzJq?=
 =?utf-8?B?V0FENWdIdWxHQnE4N05wQ01tN1c5TUFrUGoxM2JzWWN4TzBXMDlZZnJIdllM?=
 =?utf-8?B?V2ZPYzZNTkQ3d05pWHNSMzkxd3g1UDRtcVhHYTB3T3RRaTVjMHVwd3N3Vkw5?=
 =?utf-8?B?NmY3VjM4dnZrZUlBNmMxWTNVMklqb1lOT3NFcFdGSDZaYzYxejN3ZXgyVHY4?=
 =?utf-8?B?dndxSVU5dkx2YkFPVllIMDJZZDVudlkxWE1RNnpGZTBYcGFvbjFqRVF3Y1lW?=
 =?utf-8?B?THhZSG96QUExZHpjd0l2ODhjR3VWcGk5a1ByMVpaYmhlYkMvRnNVcjV0RkFu?=
 =?utf-8?B?QWZNNXNZOEpjdEQvUXRodmhiQ3ByZFlkN1Y2TVphM0pvelBjNVAzN3dTQVh0?=
 =?utf-8?B?YVdiZ0hCdGJqdnpORENqZzF1Mk80NUIwa3JlN3NZVmRHNDh1aUs0a1FVMDdp?=
 =?utf-8?B?bUt3ekpRME1SWFN4K2NLZktmR3FBTkMxclJUZzZ2ZEhSNmlKWnliMklwREFn?=
 =?utf-8?B?MWkvUUlxZjVlNi9ETUIxaThsWUlUa2lUdHFxR3Z6QnloanJyWlpjdjdSN2V6?=
 =?utf-8?B?Sk0vRmt5RG1QVTF5L1dVeGNORzFQWjByL0djOG5Wb2xJUTEzeGhuQ2g5WEY0?=
 =?utf-8?B?anhKeEU0YitHNXgzY0t6cWdER3dsS1JPaGx0NFBORVkvQ1BrUG9sd0VodTRG?=
 =?utf-8?B?ZWVMY2JxS2piYlBQdFpOSHhmazYwcy8rRjRLbjdiTEg4MHQzUkdpNHhISVBm?=
 =?utf-8?B?WFhCZUhTRUxUWnA4UGNsTHJaOUI5M2RLblk0SHk2NzJiQkFILzVBMnVoWDFS?=
 =?utf-8?B?djNmUmtLK1lNNGxNZEV0dXpzeFJUQzJUTVdLWHFyRGVSM08yRlF0cnM4Nm0z?=
 =?utf-8?B?akxwdGVJK3lzRHV6ajYwbmRTS2MwT1VURmxiQUt2MmJreGVaOE5JbVNSWlZE?=
 =?utf-8?B?QUcxNzRUNmE1QXcxa25uU3JRa0g2R2RVaUc3UjV4bTlOYTFnenpwOTgrTkRZ?=
 =?utf-8?B?cjN0VGVQS09oNDdKZFFTUmV3NVVWQnVzcHZ6ODgzQXl5SDluSEJqSTZmRksy?=
 =?utf-8?B?OFZRdFhlbEQwdkxXUGVZQjk4M3BJQTZrK0kzQ1JNdmRMY0NBNzk2VlkvV0pn?=
 =?utf-8?B?NjZmM3FPdUgycmhtZWNYQmttby80WEdyRmpGQksvVHMxUXRkb0NVQkp4UVZl?=
 =?utf-8?B?cUk0b3B1RVZLTUhLeGtxYk4rOUFKa2lHQ1hvVFk3bXRCekRiZGZYZCt1bjd5?=
 =?utf-8?B?ME5TdWNNTW95bTlxbEE1d09WOFlqZ1NQRW1ZN2Z3c3daWkowZTl5eEFSS1I5?=
 =?utf-8?B?VC92Mm9CSE5ncW9TOUVxTERmaW93U1NJYTZyV09PNWs0Mi9jYkFlK2tSaGtD?=
 =?utf-8?B?azdCbk9nZEpjOVlRckZqOUpDNmY3L25ZendVOGU0NVhKUDBBeVhIMG5DazlK?=
 =?utf-8?B?d3ZhbVhaY3JGNW9BUUFIdz09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5489ff4e-e029-4756-f4e8-08d8fe8f3a69
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 15:17:18.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToDx+BjID83fcO5q6z8mJIIVwBl1Kchvmy1s6xofmLejU8sz15ptciXaxWaYaqzHG6XLXjs8QZiJfFh8vinB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3342
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

many, though not all, of the problems are =E2=80=9Clock reclaim failed=E2=
=80=9D.

> On Apr 13, 2021, at 10:52 AM, Patrick Goetz <pgoetz@math.utexas.edu> wrot=
e:
>=20
> I use NFS 4.2 with Ubuntu 18/20 workstations and Ubuntu 18/20 servers and=
 haven't had any problems.
>=20
> Check your configuration files; the last time I experienced something lik=
e this it's because I inadvertently used the same fsid on two different exp=
orts. Also recommend exporting top level directories only.  Bind mount ever=
ything you want to export into /srv/nfs and only export those directories. =
According to Bruce F. this doesn't buy you any security (I still don't unde=
rstand why), but it makes for a cleaner system configuration.
>=20
> On 4/13/21 9:33 AM, hedrick@rutgers.edu wrote:
>> I am in charge of a large computer science dept computing infrastructure=
. We have a variety of student and develo9pment users. If there are problem=
s we=E2=80=99ll see them.
>> We use an Ubuntu 20 server, with NVMe storage.
>> I=E2=80=99ve just had to move Centos 7 and Ubuntu 18 to use NFS 4.0. We =
had hangs with NFS 4.1 and 4.2. Files would appear to be locked, although e=
ventually the lock would time out. It=E2=80=99s too soon to be sure that mo=
ving back to NFS 4.0 will fix it. Next is either NFS 3 or disabling delegat=
ions on the server.
>> Are there known versions of NFS that are safe to use in production for v=
arious kernel versions? The one we=E2=80=99re most interested in is Ubuntu =
20, which can be anything from 5.4 to 5.8.

